/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        Database.cpp                                                     *
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

#include <stdexcept>

#include "boost/lexical_cast.hpp"

#include "ConfigurationException.h"
#include "Database.h"

Fittino::Database& Fittino::Database::GetInstance() {

    static Database instance;
    return instance;

}

int Fittino::Database::GetPID( std::string particle ) {

    try {

        return _pid.at( particle );

    }
    catch ( const std::out_of_range& e ) {

        throw ConfigurationException( "PID of " + particle + " not known." );

    }

}

std::string Fittino::Database::GetPIDString( std::string particle ) {

    int pid = GetPID( particle );
    return boost::lexical_cast<std::string>( pid );

}

const std::vector<std::string>& Fittino::Database::GetSUSYParticles() {

    return _susyparticles;

}

Fittino::Database::Database() {

    AddPID( 1, "d", "dbar" );
    AddPID( 2, "u", "ubar" );
    AddPID( 3, "s", "sbar" );
    AddPID( 4, "c", "cbar" );
    AddPID( 5, "b", "bbar" );
    AddPID( 6, "t", "tbar" );

    AddPID( 11, "e",     "ebar"     );
    AddPID( 12, "nue",   "nuebar"   );
    AddPID( 13, "mu",    "mubar"    );
    AddPID( 14, "numu",  "numubar"  );
    AddPID( 15, "tau",   "taubar"   );
    AddPID( 16, "nutau", "nutaubar" );

    AddPID( 21, "g"        );
    AddPID( 22, "gamma"    );
    AddPID( 23, "Z0"       );
    AddPID( 24, "Wp", "Wm" );
    AddPID( 25, "h0"       );

    AddPID( 35, "H0"       );
    AddPID( 36, "A0"       );
    AddPID( 37, "Hp", "Hm" );

    AddSUSYParticle( 1000001, "~dL", "~dLbar" );
    AddSUSYParticle( 1000002, "~uL", "~uLbar" );
    AddSUSYParticle( 1000003, "~sL", "~sLbar" );
    AddSUSYParticle( 1000004, "~cL", "~cLbar" );
    AddSUSYParticle( 1000005, "~b1", "~b1bar" );
    AddSUSYParticle( 1000006, "~t1", "~t1bar" );

    AddSUSYParticle( 1000011, "~eL",     "~eLbar"     );
    AddSUSYParticle( 1000012, "~nueL",   "~nueLbar"   );
    AddSUSYParticle( 1000013, "~muL",    "~muLbar"    );
    AddSUSYParticle( 1000014, "~numuL",  "~numuLbar"  );
    AddSUSYParticle( 1000015, "~tau1",   "~tau1bar"   );
    AddSUSYParticle( 1000016, "~nutauL", "~nutauLbar" );

    AddSUSYParticle( 2000001, "~dR", "~dRbar" );
    AddSUSYParticle( 2000002, "~uR", "~uRbar" );
    AddSUSYParticle( 2000003, "~sR", "~sRbar" );
    AddSUSYParticle( 2000004, "~cR", "~cRbar" );
    AddSUSYParticle( 2000005, "~b2", "~b2bar" );
    AddSUSYParticle( 2000006, "~t2", "~t2bar" );

    AddSUSYParticle( 2000011, "~eR",   "~eRbar"   );
    AddSUSYParticle( 2000013, "~muR",  "~muRbar"  );
    AddSUSYParticle( 2000015, "~tau2", "~tau2bar" );

    AddSUSYParticle( 1000021, "~g"               );
    AddSUSYParticle( 1000022, "~chi10"           );
    AddSUSYParticle( 1000023, "~chi20"           );
    AddSUSYParticle( 1000024, "~chi1p", "~chi1m" );
    AddSUSYParticle( 1000025, "~chi30"           );

    AddSUSYParticle( 1000035, "~chi40"           );
    AddSUSYParticle( 1000037, "~chi2p", "~chi2m" );

}

Fittino::Database::~Database() {

}

void Fittino::Database::AddPID( int pid, std::string particle, std::string antiparticle ) {

    AddSinglePID( pid, particle );

    if ( antiparticle != "" ) {

        AddSinglePID( -pid, antiparticle );

    }

}

void Fittino::Database::AddSinglePID( int pid, std::string particle ) {

    /* \todo Check if PID already exists. */

    _pid[particle] = pid;
    _names[pid] = particle;

}

void Fittino::Database::AddSUSYParticle( int pid, std::string particle, std::string antiparticle ) {

    AddPID( pid, particle, antiparticle );

    _susyparticles.push_back( particle );

}

std::string Fittino::Database::GetName(int pid) {

    return _names[pid];

}
