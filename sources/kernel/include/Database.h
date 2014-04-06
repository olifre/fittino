/* $Id: VariableBase.h 1979 2014-03-07 23:15:24Z uhlenbrock@PHYSIK.UNI-BONN.DE $ */

/*******************************************************************************
 *                                                                              *
 * Project     Fittino - A SUSY Parameter Fitting Package                       *
 *                                                                              *
 * File        Database.h                                                       *
 *                                                                              *
 * Description Singleton class containing static data                           *
 *                                                                              *
 * Authors     Bjoern Sarrazin  <sarrazin@physik.uni-bonn.de>                   *
 *                                                                              *
 * Licence     This program is free software; you can redistribute it and/or    *
 *             modify it under the terms of the GNU General Public License as   *
 *             published by the Free Software Foundation; either version 3 of   *
 *             the License, or (at your option) any later version.              *
 *                                                                              *
 *******************************************************************************/

#ifndef FITTINO_DATABASE_H
#define FITTINO_DATABASE_H

#include <string>
#include <map>
#include <vector>

/*!
 *  \brief Fittino namespace.
 */
namespace Fittino {

    /*!
     *  \ingroup kernel
     *  \brief Singleton class containing static data
     */
    class Database {

    public:
        static Database& GetInstance();
        ~Database();
        int GetPID( std::string particle );
        std::string GetPIDString( std::string particle );
        const std::vector<std::string>& GetSUSYParticles();

    private:
        Database();
        Database( const Database& );
        void AddPID( int pid, std::string particle, std::string antiparticle = "" );
        void AddSinglePID( int pid, std::string particle );
        void AddSUSYParticle( int pid, std::string particle, std::string antiparticle = "" );
        Database& operator = ( const Database & );
        
    private:
        std::map<std::string, int> _pid;
        std::vector<std::string> _susyparticles;

    };

}

#endif
