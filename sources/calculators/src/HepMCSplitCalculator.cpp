#include <fstream>
#include <iostream>
#include <string>
#include "TMath.h"
#include "TTree.h"
#include "TFile.h"
#include "HepMC/GenEvent.h"
#include "HepMCSplitCalculator.h"
#include "HepMC/IO_GenEvent.h"
#include "boost/property_tree/ptree.hpp"

Fittino::HepMCSplitCalculator::HepMCSplitCalculator( const ModelBase* model, const boost::property_tree::ptree& ptree ) : CalculatorBase( model, &ptree )
, _hepMCFile( ptree.get<std::string>( "HepMCFile" ) ){


    _rootFile = ptree.get<std::string>( "ROOTFile" );
    _tree = ptree.get<std::string>( "Tree" );
    _eventNumber = ptree.get<std::string>( "EventNumber" );

    for( const auto& node : ptree ) {

        if ( node.first != "PDGID" ) continue;

        _pdgIDs.push_back( node.second.get_value<std::string>() );

    }
    
    for( unsigned int i = 1; i <= 5; ++i ) { 
        
         _squarks.insert( 1000000 + i );
         _squarks.insert( 2000000 + i );

    }

}

Fittino::HepMCSplitCalculator::~HepMCSplitCalculator() {

}

void Fittino::HepMCSplitCalculator::CalculatePredictions() {

	HepMC::IO_GenEvent in( _hepMCFile.string(),std::ios::in);

	HepMC::IO_GenEvent out_gg( _hepMCFile.stem().string() + "_" + "gg"  + _hepMCFile.extension().string(), std::ios::out );
	HepMC::IO_GenEvent out_sg( _hepMCFile.stem().string() + "_" + "sg"  + _hepMCFile.extension().string(), std::ios::out );
	HepMC::IO_GenEvent out_ss( _hepMCFile.stem().string() + "_" + "ss"  + _hepMCFile.extension().string(), std::ios::out );
	HepMC::IO_GenEvent out_sb( _hepMCFile.stem().string() + "_" + "sb"  + _hepMCFile.extension().string(), std::ios::out );
	HepMC::IO_GenEvent out_st1( _hepMCFile.stem().string() + "_" + "st1" + _hepMCFile.extension().string(), std::ios::out );
	HepMC::IO_GenEvent out_st2( _hepMCFile.stem().string() + "_" + "st2" + _hepMCFile.extension().string(), std::ios::out );

    TDirectory* pwd = gDirectory;
    TFile* f = TFile::Open( _rootFile.c_str(), "READ" );
    TTree* tree = dynamic_cast<TTree*>( f->Get( _tree.c_str() ) );

    int id1, id2;
    unsigned int eventNumber;
    unsigned int index = 0;
    tree->SetBranchAddress( _pdgIDs.at( 0 ).c_str(), &id1 );
    tree->SetBranchAddress( _pdgIDs.at( 1 ).c_str(), &id2 );
    tree->SetBranchAddress( _eventNumber.c_str(), &eventNumber );
    
	HepMC::GenEvent* evt = in.read_next_event();

	while ( evt ) {

        if ( tree->GetEntry( index ) <= 0 ) throw ConfigurationException("Not enough events in file " + _rootFile);

        if ( evt->event_number() != eventNumber ) throw ConfigurationException( "Event numbers do not match." );

                if ( _squarks.count( TMath::Abs( id1 ) ) && _squarks.count( TMath::Abs( id2 ) ) && TMath::Sign( id1, id2 ) != id1 )  out_sb << evt;

                if ( _squarks.count( TMath::Abs( id1 ) ) && _squarks.count( TMath::Abs( id2 ) ) && TMath::Sign( id1, id2 ) == id1 )  out_ss << evt;

                if ( id1 == 1000021 && id2 == 1000021 ) out_gg << evt;

                if ( _squarks.count( TMath::Abs( id1 ) ) && id2 == 1000021 ) out_sg << evt;
                if ( _squarks.count( TMath::Abs( id2 ) ) && id1 == 1000021 ) out_sg << evt;

                if ( TMath::Abs( id1 ) == 1000006 && TMath::Abs( id2 ) == 1000006 && TMath::Sign( id1, id2 ) != id1 ) out_st1 << evt;
                
                if ( TMath::Abs( id1 ) == 2000006 && TMath::Abs( id2 ) == 2000006 && TMath::Sign( id1, id2 ) != id1 ) out_st2 << evt;

		delete evt;
		in >> evt;
        ++index;

	}

    if ( tree->GetEntries() != index ) throw ConfigurationException( "Too many events in file" + _rootFile + ", expected " + std::to_string( index ) + " got " + std::to_string( tree->GetEntries() ) ); 

    f->Close();
    pwd->cd();

}

