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

    Fittino::HepMCSplitCalculator::HepMCSplitCalculator( const ModelBase* model, const boost::property_tree::ptree& ptree )
: CalculatorBase( model, &ptree )
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

        AddOutput("NumberOfEvents_total", index );
        AddOutput("NumberOfEvents_gg", _n_gg );
        AddOutput("NumberOfEvents_sg", _n_sg );
        AddOutput("NumberOfEvents_ss", _n_ss );
        AddOutput("NumberOfEvents_sb", _n_sb );
        AddOutput("NumberOfEvents_tb1", _n_tb1 );
        AddOutput("NumberOfEvents_tb2", _n_tb2 );

        AddOutput("NumberOfEvents_ns1", _n_ns1 );
        AddOutput("NumberOfEvents_ns2", _n_ns2 );
        AddOutput("NumberOfEvents_ns3", _n_ns3 );
        AddOutput("NumberOfEvents_ns4", _n_ns4 );
        AddOutput("NumberOfEvents_ns5", _n_ns5 );
        AddOutput("NumberOfEvents_ns6", _n_ns6 );
        AddOutput("NumberOfEvents_ns7", _n_ns7 );
        AddOutput("NumberOfEvents_ns8", _n_ns8 );

        AddOutput("NumberOfEvents_ng1", _n_ng1 );
        AddOutput("NumberOfEvents_ng2", _n_ng2 );
        AddOutput("NumberOfEvents_ng3", _n_ng3 );
        AddOutput("NumberOfEvents_ng4", _n_ng4 );
        AddOutput("NumberOfEvents_ng5", _n_ng5 );
        AddOutput("NumberOfEvents_ng6", _n_ng6 );
        AddOutput("NumberOfEvents_ng7", _n_ng7 );
        AddOutput("NumberOfEvents_ng8", _n_ng8 );
    }

Fittino::HepMCSplitCalculator::~HepMCSplitCalculator() {

}

std::string Fittino::HepMCSplitCalculator::GetProcess( int id1, int id2 ) {
    std::string process;

        if ( id1 == 1000021 && id2 == 1000021 ) process = "gg";

        if ( _squarks.count( TMath::Abs( id1 ) ) && id2 == 1000021 ||
                _squarks.count( TMath::Abs( id2 ) ) && id1 == 1000021   ) process = "sg";

        if ( _squarks.count( TMath::Abs( id1 ) ) && _squarks.count( TMath::Abs( id2 ) ) && TMath::Sign( id1, id2 ) == id1 ) process = "ss";

        if ( _squarks.count( TMath::Abs( id1 ) ) && _squarks.count( TMath::Abs( id2 ) ) && TMath::Sign( id1, id2 ) != id1 ) process = "sb";

        if ( TMath::Abs( id1 ) == 1000006 && TMath::Abs( id2 ) == 1000006 && TMath::Sign( id1, id2 ) != id1 ) process = "tb1";

        if ( TMath::Abs( id1 ) == 2000006 && TMath::Abs( id2 ) == 2000006 && TMath::Sign( id1, id2 ) != id1 ) process = "tb2";

        return process;

}

void Fittino::HepMCSplitCalculator::CalculatePredictions() {

    _n_gg = 0;
    _n_sg = 0;
    _n_ss = 0;
    _n_sb = 0;
    _n_tb1 = 0;
    _n_tb2 = 0;

    _n_ns1 = 0;
    _n_ns2 = 0;
    _n_ns3 = 0;
    _n_ns4 = 0;
    _n_ns5 = 0;
    _n_ns6 = 0;
    _n_ns7 = 0;
    _n_ns8 = 0;

    _n_ng1 = 0;
    _n_ng2 = 0;
    _n_ng3 = 0;
    _n_ng4 = 0;
    _n_ng5 = 0;
    _n_ng6 = 0;
    _n_ng7 = 0;
    _n_ng8 = 0;

    HepMC::IO_GenEvent in( _hepMCFile.string(),std::ios::in);

    std::map<std::string, HepMC::IO_GenEvent*> _outFiles;  

    for ( std::string process : { "gg", "sg", "ss", "sb", "tb1", "tb2" } ) {
    
        HepMC::IO_GenEvent* file= new HepMC::IO_GenEvent( _hepMCFile.stem().string() + "_" + process  + _hepMCFile.extension().string(), std::ios::out );

        _outFiles.insert( { process, file } );

        AddOutput( "NumberOfEvents_" + process );

    }

    HepMC::IO_GenEvent out_gg( _hepMCFile.stem().string() + "_" + "gg"  + _hepMCFile.extension().string(), std::ios::out );
    HepMC::IO_GenEvent out_sg( _hepMCFile.stem().string() + "_" + "sg"  + _hepMCFile.extension().string(), std::ios::out );
    HepMC::IO_GenEvent out_ss( _hepMCFile.stem().string() + "_" + "ss"  + _hepMCFile.extension().string(), std::ios::out );
    HepMC::IO_GenEvent out_sb( _hepMCFile.stem().string() + "_" + "sb"  + _hepMCFile.extension().string(), std::ios::out );
    HepMC::IO_GenEvent out_tb1( _hepMCFile.stem().string() + "_" + "tb1" + _hepMCFile.extension().string(), std::ios::out );
    HepMC::IO_GenEvent out_tb2( _hepMCFile.stem().string() + "_" + "tb2" + _hepMCFile.extension().string(), std::ios::out );

    TDirectory* pwd = gDirectory;
    TFile* f = TFile::Open( _rootFile.c_str(), "READ" );
    TTree* tree = dynamic_cast<TTree*>( f->Get( _tree.c_str() ) );

    int id1, id2;
    unsigned int eventNumber;
    tree->SetBranchAddress( _pdgIDs.at( 0 ).c_str(), &id1 );
    tree->SetBranchAddress( _pdgIDs.at( 1 ).c_str(), &id2 );
    tree->SetBranchAddress( _eventNumber.c_str(), &eventNumber );

    HepMC::GenEvent* evt = in.read_next_event();

    while ( evt ) {

        if ( tree->GetEntry( index ) <= 0 ) throw ConfigurationException("Not enough events in file " + _rootFile);

        if ( evt->event_number() != eventNumber ) throw ConfigurationException( "Event numbers do not match." );

        std::string process = GetProcess( id1, id2 );
        *_outFiles.at( process ) << evt;
        std::string name = "NumberOfEvents_" + process;
        SetOutput( name, GetOutput( name ) + 1 ); 

        delete evt;
        in >> evt;
        ++index;

    }

    if ( tree->GetEntries() != index ) throw ConfigurationException( "Too many events in file" + _rootFile + ", expected " + std::to_string( index ) + " got " + std::to_string( tree->GetEntries() ) ); 

    f->Close();
    pwd->cd();

}

