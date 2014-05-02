/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        SplineCut.cpp                                              *
*                                                                              *
* Description Base class for cuts                                     *
*                                                                              *
* Authors     Matthias Hamer      <mhamer@cbpf.br>                             *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include "TFile.h"
#include "TSpline.h"
#include "TDirectory.h"

#include "SplineCut.h"

Fittino::SplineCut::SplineCut( ModelBase* model, const boost::property_tree::ptree& ptree ) 
    : _xValue ( model->GetCollectionOfQuantities().At( ptree.get<std::string>( "XValue" ) )->GetValue() ),
      _yValue ( model->GetCollectionOfQuantities().At( ptree.get<std::string>( "YValue" ) )->GetValue() ) {

    std::string fileName        = ptree.get<std::string>( "InputFileName" );
    std::string splineName      = ptree.get<std::string>( "SplineName" );
    _isUpperBound               = ptree.get<bool>       ( "IsUpperBound", false );

    TDirectory *tempDirectory = gDirectory;

    TFile *inputFile = new TFile( fileName.c_str() );
    if( inputFile ) {

        std::string message = "Could not open input file " + fileName + " for SplineCut object";
        throw ConfigurationException( message );

    }

    TSpline3 *spline = (TSpline3*)inputFile->Get( splineName.c_str() );
    if( !spline ) {

        std::string message = "Could not read TSpline3 with name " + splineName + " in file " + fileName;
        throw ConfigurationException( message );

    }
    _spline = (TSpline3*)spline->Clone("");

    delete spline;
    inputFile->Close();
    delete inputFile;

    gDirectory = tempDirectory;

}

Fittino::SplineCut::~SplineCut() {

    delete _spline;

}

bool Fittino::SplineCut::IsPassed() {

    bool passed = true;
    if( _isUpperBound ) {
        
        if( _yValue > _spline->Eval( _xValue ) ) {

            passed = false;

        }

    }
    else {

        if( _yValue < _spline->Eval( _xValue ) ) {

            passed = false;

        }

    }

    return passed;

}
