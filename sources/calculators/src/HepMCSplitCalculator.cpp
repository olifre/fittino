#include <fstream>
#include <iostream>
#include <string>
#include "TMath.h"
#include "HepMC/GenEvent.h"
#include "HepMCSplitCalculator.h"
#include "HepMC/IO_GenEvent.h"

Fittino::HepMCSplitCalculator::HepMCSplitCalculator( const ModelBase* model, const boost::property_tree::ptree& ptree ) : CalculatorBase( model, &ptree ) {

    for( unsigned int i = 1; i <= 5; ++i ) { 
        
         _squarks.insert( 1000000 + i );
         _squarks.insert( 2000000 + i );

    }

}

Fittino::HepMCSplitCalculator::~HepMCSplitCalculator() {

}

void Fittino::HepMCSplitCalculator::CalculatePredictions() {

	HepMC::IO_GenEvent in("LHC-MSSM.hepmc",std::ios::in);

	HepMC::IO_GenEvent out_sb("LHC-MSSM_sb.hepmc",std::ios::out);
	HepMC::IO_GenEvent out_ss("LHC-MSSM_ss.hepmc",std::ios::out);
	HepMC::IO_GenEvent out_gg("LHC-MSSM_gg.hepmc",std::ios::out);
	HepMC::IO_GenEvent out_sg("LHC-MSSM_sg.hepmc",std::ios::out);
	HepMC::IO_GenEvent out_st1("LHC-MSSM_st1.hepmc",std::ios::out);
	HepMC::IO_GenEvent out_st2("LHC-MSSM_st2.hepmc",std::ios::out);

	HepMC::GenEvent* evt = in.read_next_event();

       int id1, id2;

	while ( evt ) {

                std::cout << "Processing Event Number " << " its # " << evt->event_number()<< std::endl;

                if ( _squarks.count( TMath::Abs( id1 ) ) && _squarks.count( TMath::Abs( id2 ) )  && id1 * id2 < 0 )  out_sb << evt;

                if ( _squarks.count( TMath::Abs( id1 ) ) && _squarks.count( TMath::Abs( id2 ) ) && id1 * id2 > 0 )  out_ss << evt;

                if ( id1 == 1000021 && id2 == 1000021 ) out_gg << evt;

                if ( _squarks.count( TMath::Abs( id1 ) ) && id2 == 1000021 ) out_sg << evt;
                if ( _squarks.count( TMath::Abs( id2 ) ) && id1 == 1000021 ) out_sg << evt;

                if ( TMath::Abs( id1 ) == 1000006 && TMath::Abs( id2 ) == 1000006 && id1 * id2 < 0 ) out_st1 << evt;

                if ( TMath::Abs( id1 ) == 2000006 && TMath::Abs( id2 ) == 2000006 && id1 * id2 < 0 ) out_st2 << evt;

		delete evt;
		in >> evt;

	}

}

void Fittino::HepMCSplitCalculator::Initialize() {

}
