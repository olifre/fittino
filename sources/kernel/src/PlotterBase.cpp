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
#include "TGraph.h"
#include "TH1.h"
#include "TImage.h"
#include "TStyle.h"
#include "TText.h"
#include "TLine.h"

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
      _fittinoLogo    ( 0 ),
      _fileFormat     ( ptree.get<std::string>( "FileFormat", "eps" ) ),
      _pageFormat     ( ptree.get<std::string>( "PageFormat", "Landscape" ) ),
      _name           ( "" ),
      _version        ( ptree.get<std::string>( "Version", "" ) ),
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

    // Global style settings.

    _fittinoStyle->SetOptTitle( 0 );
    _fittinoStyle->SetOptStat( 0 );

    _fittinoStyle->SetTextFont( _textFont );
    _fittinoStyle->SetLabelFont(_textFont,"x");
    _fittinoStyle->SetTitleFont(_textFont,"x");
    _fittinoStyle->SetLabelFont(_textFont,"y");
    _fittinoStyle->SetTitleFont(_textFont,"y");
    _fittinoStyle->SetLabelFont(_textFont,"z");
    _fittinoStyle->SetTitleFont(_textFont,"z");
          
    _fittinoStyle->SetTextSize( _textSize );
    _fittinoStyle->SetLabelSize(_textSize,"x");
    _fittinoStyle->SetTitleSize(_textSize,"x");
    _fittinoStyle->SetLabelSize(_textSize,"y");
    _fittinoStyle->SetTitleSize(_textSize,"y");
    _fittinoStyle->SetLabelSize(_textSize,"z");
    _fittinoStyle->SetTitleSize(_textSize,"z");

    _fittinoStyle->SetTitleOffset( 1.3, "x" );
    _fittinoStyle->SetTitleOffset( 1.3, "y" );
    _fittinoStyle->SetTitleOffset( 1.3, "z" );

    _fittinoStyle->SetFrameBorderMode( 0 );
          
          
    std::string logoPath = ptree.get<std::string>( "LogoPath", ""  );
          
    if ( ! logoPath.empty() ) {
              
        _fittinoLogo = TImage::Open( logoPath.c_str() );
              
        if ( !_fittinoLogo->IsValid() ) {
              
            throw ConfigurationException( "Could not open the fittino logo at " + logoPath );
                  
        }
   
    }

}

Fittino::PlotterBase::~PlotterBase() {

    delete _canvas;
    delete _fittinoStyle;

}

void Fittino::PlotterBase::AddGraph( TGraph* graph ) {
    
    
    _graphVector.push_back( graph );
    
}

void Fittino::PlotterBase::AddHistogram( TH1* histogram ) {
    
    _histogramVector.push_back( histogram );
    
}

void Fittino::PlotterBase::MakePlots() {

    Messenger& messenger = Messenger::GetInstance();

    messenger << Messenger::ALWAYS << Messenger::_dashedLine << Messenger::Endl;
    messenger << Messenger::ALWAYS << Messenger::Endl;
    messenger << Messenger::ALWAYS << "  Making plots" << Messenger::Endl;
    messenger << Messenger::ALWAYS << Messenger::Endl;

    // Loop over all histograms.

    for ( unsigned int iHistogram = 0; iHistogram < _histogramVector.size(); ++iHistogram ) {

        messenger << Messenger::ALWAYS<<"    Plotting " << _histogramVector[iHistogram]->GetName() << Messenger::Endl;

        Plot( iHistogram );

        if ( !_version.empty() ) {

            AddVersion();

        }
        
        if ( _fittinoLogo ) {

            DrawLogo();
            
        }
        
//        TLine* line = new TLine();
//
//        double xmin =_histogramVector.at( iHistogram )->GetXaxis()->GetXmin();
//        double xmax =_histogramVector.at( iHistogram )->GetXaxis()->GetXmax();
//
//        double ymin =_histogramVector.at( iHistogram )->GetYaxis()->GetXmin();
//        double ymax =_histogramVector.at( iHistogram )->GetYaxis()->GetXmax();
//
//        double firstPoint = TMath::Max( xmin, ymin );
//        double secondPoint = TMath::Min( xmax, ymax );
//
//        line->SetLineStyle( 2 );      // Dashed
//        line->SetLineColor( kBlack ); // Black
//        line->DrawLine( firstPoint, firstPoint, secondPoint, secondPoint );

        if ( _logScaleX ) _pad->SetLogx( 1 );
        if ( _logScaleY ) _pad->SetLogy( 1 );
        if ( _logScaleZ ) _pad->SetLogz( 1 );

        _canvas->Update();

        Redirector redirector( "/dev/null" );
        
        if ( messenger.GetVerbosityLevel() > Messenger::ALWAYS ) {
            /* \todo Rearrange verbosity levels. At the moment, the following will never be executed. */
            redirector.Start();
            
        }

        _canvas->SaveAs( static_cast<TString>( _histogramVector[iHistogram]->GetName() ) + "." + _fileFormat, "RECREATE" );
        
        if ( messenger.GetVerbosityLevel() > Messenger::ALWAYS ) {
        
            redirector.Stop();
            
        }

    }

    _pad->SetLogx( 0 );
    _pad->SetLogy( 0 );
    _pad->SetLogz( 0 );

    messenger << Messenger::ALWAYS << Messenger::Endl;

}

void Fittino::PlotterBase::PrintSteeringParameters() const {

}

void Fittino::PlotterBase::DrawLogo() {
    
    _fittinoLogo->SetConstRatio(1);
    _fittinoLogo->SetImageQuality(TAttImage::kImgBest);
    _fittinoLogo->SetImageCompression(0);
    
    const float canvasHeight   = _canvas->GetWindowHeight();
    const float canvasWidth    = _canvas->GetWindowWidth();
    const float canvasAspectRatio = canvasHeight/canvasWidth;
    const float width          = 0.19;
    const float xLowerEdge     = 0.02;
    const float yLowerEdge     = 0.853;
    const float xUpperEdge     = xLowerEdge+width;
    const float yUpperEdge     = yLowerEdge+width*_fittinoLogo->GetHeight()/_fittinoLogo->GetWidth()/canvasAspectRatio;

    TPad *fittinoLogoPad = new TPad("fittinoLogoPad", "fittinoLogoPad", xLowerEdge, yLowerEdge, xUpperEdge, yUpperEdge);
    fittinoLogoPad->Draw("same");
    fittinoLogoPad->cd();
    _fittinoLogo->Draw("xxx");
    _canvas->cd();
    
}

void Fittino::PlotterBase::AddVersion() {
    
        
    TText fittinoVersion;
    fittinoVersion.SetTextFont( 82 );
    std::string versionText = "Fittino Version " + _version;
    
    if ( _pageFormat == "Landscape" ) {
        
        fittinoVersion.DrawTextNDC( 0.570, 0.95, versionText.c_str() );
        
    }
    else if ( _pageFormat == "Square" ) {
        
        fittinoVersion.DrawTextNDC( 0.460, 0.95, versionText.c_str() );
        
    }
    else if ( _pageFormat == "Summary" ) {
        
        fittinoVersion.SetTextSize( 0.035 );
        fittinoVersion.DrawTextNDC( 0.05, 0.035, versionText.c_str() );
        
    }
    
}