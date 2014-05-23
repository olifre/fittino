/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        PlotterBase.cpp                                                  *
*                                                                              *
* Description Base class for plotters                                          *
*                                                                              *
* Authors     Mathias Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>              *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include <boost/property_tree/ptree.hpp>

#include "TCanvas.h"
#include "TH1.h"
#include "TStyle.h"
#include "TText.h"

#include "ConfigurationException.h"
#include "Messenger.h"
#include "PlotterBase.h"
#include "Redirector.h"

Fittino::PlotterBase::PlotterBase( std::vector<TH1*>& histogramVector, const boost::property_tree::ptree& ptree )
    : _logScaleX      ( ptree.get<bool>( "LogScaleX", false ) ),
      _logScaleY      ( ptree.get<bool>( "LogScaleY", false ) ),
      _logScaleZ      ( ptree.get<bool>( "LogScaleZ", false ) ),
      _textSize       ( 0.04 ),
      _textFont       ( 42 ), // Helvetica
      _fileFormat     ( ptree.get<std::string>( "FileFormat", "eps" ) ),
      _pageFormat     ( ptree.get<std::string>( "PageFormat", "Landscape" ) ),
      _name           ( "" ),
      _version        ( "2.0.X" ),
      _canvas         ( 0 ),
      _pad            ( 0 ),
      _fittinoStyle   ( new TStyle( "FITTINO", "Fittino style" ) ),
      _histogramVector( histogramVector ) {

    // Format settings.

    if ( _pageFormat == "Landscape" ) {

        _canvas = new TCanvas( "Canvas", "Canvas", 800, 600 );

    }
    else if ( _pageFormat == "Square" ) {

        _canvas = new TCanvas( "Canvas", "Canvas", 600, 600 );

    }
    else if ( _pageFormat == "Summary" ) {

        _canvas = new TCanvas( "Canvas", "Canvas", 600, 800 );

    }
    else {

        throw ConfigurationException( "Plot format not known." );

    }

    _pad = ( TPad* )_canvas->cd();

    if ( _logScaleX ) _pad->SetLogx( 1 );
    if ( _logScaleY ) _pad->SetLogy( 1 );
    if ( _logScaleZ ) _pad->SetLogz( 1 );

    // Global style settings.

    _fittinoStyle->SetOptTitle( 0 );
    _fittinoStyle->SetOptStat( 0 );

    _fittinoStyle->SetTextFont( _textFont );
    _fittinoStyle->SetTextSize( _textSize );

    _fittinoStyle->SetTitleOffset( 1.3, "x" );
    _fittinoStyle->SetTitleOffset( 1.3, "y" );
    _fittinoStyle->SetTitleOffset( 1.3, "z" );

    _fittinoStyle->SetFrameBorderMode( 0 );

}

Fittino::PlotterBase::~PlotterBase() {

    delete _canvas;
    delete _fittinoStyle;

}

void Fittino::PlotterBase::MakePlots() {

    Messenger& messenger = Messenger::GetInstance();

    messenger << Messenger::ALWAYS << Messenger::_dashedLine << Messenger::Endl;
    messenger << Messenger::ALWAYS << Messenger::Endl;
    messenger << Messenger::ALWAYS << "  Making plots" << Messenger::Endl;
    messenger << Messenger::ALWAYS << Messenger::Endl;

    // Loop over all histograms.

    for ( unsigned int iHistogram = 0; iHistogram < _histogramVector.size(); ++iHistogram ) {

        messenger << "    Plotting " << _histogramVector[iHistogram]->GetName() << Messenger::Endl;

        // Plot the histograms.

        Plot( iHistogram );

        // Add fittino version.

        TText fittinoVersion;
        fittinoVersion.SetTextFont( 82 );
        std::string versionText = "Fittino Version " + _version;

        if ( _pageFormat == "Landscape" ) {

            fittinoVersion.DrawTextNDC( 0.575, 0.95, versionText.c_str() );

        }
        else if ( _pageFormat == "Square" ) {

            fittinoVersion.DrawTextNDC( 0.460, 0.95, versionText.c_str() );

        }
        else if ( _pageFormat == "Summary" ) {

            fittinoVersion.SetTextSize( 0.035 );
            fittinoVersion.DrawTextNDC( 0.05, 0.035, versionText.c_str() );

        }

        // Save the plots to .eps files.

        _canvas->Update();

        Redirector redirector( "/dev/null" );
        redirector.Start();

        _canvas->SaveAs( static_cast<TString>( _histogramVector[iHistogram]->GetName() ) + "." + _fileFormat, "RECREATE" );

        redirector.Stop();

    }

    messenger << Messenger::ALWAYS << Messenger::Endl;

}

void Fittino::PlotterBase::PrintSteeringParameters() const {

}
