/* $Id$ */

/*******************************************************************************
*                                                                              *
* Project     Fittino - A SUSY Parameter Fitting Package                       *
*                                                                              *
* File        EdgeDetectionTool.cpp                                            *
*                                                                              *
* Description Class to run an Edge Detection for finding buggy points          *
*                                                                              *
* Authors     Matthias Hamer       <mhamer@cbpf.br>                            *
*             Mathias  Uhlenbrock  <uhlenbrock@physik.uni-bonn.de>             *
*                                                                              *
* Licence     This program is free software; you can redistribute it and/or    *
*             modify it under the terms of the GNU General Public License as   *
*             published by the Free Software Foundation; either version 3 of   *
*             the License, or (at your option) any later version.              *
*                                                                              *
*******************************************************************************/

#include <boost/foreach.hpp>

#include "EdgeDetectionTool.h"
#include "ModelBase.h"

#include "TH2D.h"
#include "TFile.h"
#include "TGraph.h"
#include "TSpline.h"
#include "TDirectory.h"

Fittino::EdgeDetectionTool::EdgeDetectionTool( ModelBase *model, const boost::property_tree::ptree& ptree )
    : Tool                    ( model, ptree ),
      _numberOfCleaningSteps  ( ptree.get<unsigned int>( "NumberOfCleaningSteps", 1 ) ),
      _histogramFileName      ( ptree.get<std::string> ( "HistogramFileName", "" ) ) {


    BOOST_FOREACH( const boost::property_tree::ptree::value_type& node, ptree ) {

        if( node.first == "UseHistogram" ) {
            
            _histogramNameVector.push_back( node.second.data() );         

        }

    }

}

Fittino::EdgeDetectionTool::~EdgeDetectionTool() {

}

void Fittino::EdgeDetectionTool::InitializeTool() {

    TDirectory *tempDirectory = gDirectory;

    TFile *histogramFile = new TFile( _histogramFileName.c_str(), "OPEN" );
    if ( !histogramFile ) {

        throw ConfigurationException( "Could not find file containing the input histograms. Check the filename in the Fittino input file!" );
    
    }
    
    for( unsigned int i = 0; i <= _histogramNameVector.size(); ++i ) {

        TH2D *histogram = (TH2D*)histogramFile->Get( _histogramNameVector.at(i).c_str() );
        if( !histogram ) {
            
            const std::string exception = "Could not find requested histogram " + _histogramNameVector.at(i) + " in file.";
            throw ConfigurationException( exception );

        }
        
        else {

            _histogramVector.push_back( (TH2D*)histogram->Clone("") );
    
        }

    }

    histogramFile->Close();
    delete histogramFile;

    gDirectory = tempDirectory;

}

void Fittino::EdgeDetectionTool::Execute() {

    std::vector<TH2D*> hcHistograms;
    std::vector<TH2D*> edgeHistograms;

    for( unsigned int i = 0; i < _histogramVector.size(); ++i ) {

        //create the high contrast histogram
        hcHistograms.push_back( (TH2D*)_histogramVector.at(i)->Clone("") );
        for( int binX = 0; binX <= hcHistograms.at(i)->GetNbinsX(); ++binX ) {

            for( int binY = 0; binY <= hcHistograms.at(i)->GetNbinsY(); ++binY ) {

                if( hcHistograms.at(i)->GetBinContent(binX,binY) > 0. ) {

                    hcHistograms.at(i)->SetBinContent(binX,binY, 1.);

                }

                else {

                    hcHistograms.at(i)->SetBinContent(binX,binY, 0. );

                }

            }
            
        }

        //now create the edge hisotgrams and remove the outliers:
        edgeHistograms.push_back( (TH2D*)_histogramVector.at(i)->Clone("") );
        unsigned int cleaningStep = 0;
        while( cleaningStep < _numberOfCleaningSteps ) {
        
            for( int binX = 0; binX < hcHistograms.at(i)->GetNbinsX(); ++binX ) {

                for( int binY = 0; binY < hcHistograms.at(i)->GetNbinsY(); ++binY ) {

                    double cross = abs(   hcHistograms.at(i)->GetBinContent( binX,     binY     )  
                                        - hcHistograms.at(i)->GetBinContent( binX + 1, binY + 1 ) )
                                 + abs(   hcHistograms.at(i)->GetBinContent( binX + 1, binY     )
                                        - hcHistograms.at(i)->GetBinContent( binX    , binY + 1 ) );
                    edgeHistograms.at(i)->SetBinContent( binX, binY, cross );

                }
           
           }

            for( int binX = 0; binX < hcHistograms.at(i)->GetNbinsX(); ++binX ) {

                for( int binY = 0; binY < hcHistograms.at(i)->GetNbinsY(); ++binY ) {

                    double difference =   hcHistograms.at(i)->GetBinContent( binX, binY )
                                        - edgeHistograms.at(i)->GetBinContent( binX, binY );
                    if( difference < 0. || difference > 0. ) {

                        continue;

                    }

                    else {

                        hcHistograms.at(i)->SetBinContent( binX, binY, 0. );

                    }

                }

            }
            ++cleaningStep;
        
        }
        
        std::vector<double> xvalues;
        std::vector<double> yvalues;
        for( int binX = 0; binX < hcHistograms.at(i)->GetNbinsX(); ++binX ) {
            double xval = hcHistograms.at(i)->GetXaxis()->GetBinCenter(binX); 
            double yval = hcHistograms.at(i)->GetYaxis()->GetXmin();

            for( int binY = 0; binY < hcHistograms.at(i)->GetNbinsY(); ++binY ) {

                yval = hcHistograms.at(i)->GetYaxis()->GetBinCenter(binY);
                if( edgeHistograms.at(i)->GetBinContent(binX, binY) > 0. ) {

                    break;

                }

            }
            xvalues.push_back( xval );
            yvalues.push_back( yval );

        }
        
        unsigned int numberOfNodes = xvalues.size();

        TGraph *graph = new TGraph( numberOfNodes, &xvalues.at(0), &yvalues.at(0) );
        std::string splineName = _histogramNameVector.at(i) + "_spline";
        TSpline3 *spline = new TSpline3( splineName.c_str(), graph );
        spline->SetLineColor(kRed);
        spline->SetLineWidth(4);
        spline->SetNpx(1000);
        _splineVector.push_back( (TSpline3*)spline->Clone("") );
        delete graph;
        delete spline;

    }

}
void Fittino::EdgeDetectionTool::Terminate() {

}

void Fittino::EdgeDetectionTool::PrintSteeringParameters() const {

}

void Fittino::EdgeDetectionTool::UpdateModel() { 

}

void Fittino::EdgeDetectionTool::PrintResult() const {

}

void Fittino::EdgeDetectionTool::WriteResultToFile() const {

    for ( unsigned int i = 0; i < _splineVector.size(); ++i ) {

        _splineVector.at(i)->Write();

    }

}
