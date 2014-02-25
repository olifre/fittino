/* $Id: AnalysisTool.cpp 1883 2014-02-08 12:22:59Z uhlenbrock@PHYSIK.UNI-BONN.DE $ */

/*******************************************************************************
 *                                                                              *
 * Project     Fittino - A SUSY Parameter Fitting Package                       *
 *                                                                              *
 * File        Redirector.h                                                     *
 *                                                                              *
 * Description Redirects stdout and stderr to a file                            *
 *                                                                              *
 * Authors     Bjoern Sarrazin     <sarrazin@physik.uni-bonn.de>                *
 *                                                                              *
 * Licence     This program is free software; you can redistribute it and/or    *
 *             modify it under the terms of the GNU General Public License as   *
 *             published by the Free Software Foundation; either version 3 of   *
 *             the License, or (at your option) any later version.              *
 *                                                                              *
 *******************************************************************************/

#ifndef FITTINO_REDIRECTOR_H
#define FITTINO_REDIRECTOR_H

#include <string>

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

    /*!
     *  \ingroup kernel
     *  \brief Redirects stdout and stderr to a file  
     */
  class Redirector {

    public:
      Redirector ( std::string fileName );
      ~Redirector();
      void Start();
      void Stop();

    private:
      bool _redirecting;
      void StartRedirection( FILE* stream, int& backup);
      void StopRedirection( FILE* stream, int& backup);
      std::string _fileName;
      int _fd_stdout;
      int _fd_stderr;
      int _fd_file;

  };

}

#endif
