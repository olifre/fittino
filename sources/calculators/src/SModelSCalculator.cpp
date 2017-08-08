#include <boost/python.hpp>
#include <boost/property_tree/ptree.hpp>
#include <boost/property_tree/xml_parser.hpp>
#include <Python.h>
#include <iostream>
#include <CalculatorException.h>
#include <LogicException.h>
#include "Executor.h"
#include "SModelSCalculator.h"
#include "Messenger.h"

Fittino::SModelSCalculator::SModelSCalculator(const ModelBase *model, const boost::property_tree::ptree &ptree)
        : CalculatorBase(model, &ptree) {

    AddOutput( "R_Value", _rValue );

    std::string exename = "SModelSToolsExecutable";

#ifdef SModelSTools_EXECUTABLE

    std::string executable = ptree.get<std::string>( exename, SModelSTools_EXECUTABLE );

#else

    if ( ptree.count(exename) == 0 ) {

        throw ConfigurationException("SModelSTools was not found. Please set " + exename + " in the input file.");

    }

    std::string executable = ptree.get<std::string>(exename);

#endif

     _fileName = ptree.get<std::string>( "FileName" );

    _xmlFile = "results/" + _fileName + ".xml";

    _parameterFile = ptree.get<std::string>( "ParameterFile" );

    _crossSections_LO = new Executor( executable, "smodelsTools.py" );
    _crossSections_LO->AddArgument("xseccomputer");
    _crossSections_LO->AddArgument("-s");
    _crossSections_LO->AddArgument("8");
    _crossSections_LO->AddArgument("13");
    _crossSections_LO->AddArgument("-e");
    _crossSections_LO->AddArgument("10000");
    _crossSections_LO->AddArgument("-p");
    _crossSections_LO->AddArgument("-f");
    _crossSections_LO->AddArgument(_fileName);

    _crossSections_NLL = new Executor( executable, "smodelsTools.py" );
    _crossSections_NLL->AddArgument("xseccomputer");
    _crossSections_NLL->AddArgument("-s");
    _crossSections_NLL->AddArgument("8");
    _crossSections_NLL->AddArgument("13");
    _crossSections_NLL->AddArgument("-p");
    _crossSections_NLL->AddArgument("-N");
    _crossSections_NLL->AddArgument("-O");
    _crossSections_NLL->AddArgument("-f");
    _crossSections_NLL->AddArgument(_fileName);

    auto modelTester = boost::python::import("smodels.tools.modelTester");
    auto getParameters = modelTester.attr( "getParameters" );
    auto loadDatabase = modelTester.attr( "loadDatabase" );
    auto loadDatabaseResults = modelTester.attr( "loadDatabaseResults" );
    auto getAllInputFiles = modelTester.attr( "getAllInputFiles" );

    _testPoints = modelTester.attr( "testPoints" );

    _fileList = getAllInputFiles( _fileName );

    _parser = getParameters( _parameterFile );

    auto databaseTuple = loadDatabase( _parser, boost::python::object() );
    boost::python::object database = databaseTuple[0];
    _databaseVersion = boost::python::extract<std::string>(databaseTuple[1] );

    _listOfExpRes = loadDatabaseResults( _parser, database );

    unsigned int nResults = boost::python::len( _listOfExpRes );

    for( unsigned int i = 0; i < nResults; ++i ) {

        auto txNamesPerResult = _listOfExpRes[i].attr( "getTxNames" )();

        unsigned int nTxNames = boost::python::len( txNamesPerResult );

        for( unsigned int j = 0; j < nTxNames; ++j ) {

            std::string txName = boost::python::extract<std::string>( txNamesPerResult[j].attr( "txName" ) );

            _txNamesWithResults.insert( txName );

        }

    }

    Messenger& messenger = Messenger::GetInstance();
    messenger << Messenger::INFO << "SModelS database version: " <<_databaseVersion<< Messenger::Endl;
    messenger << Messenger::INFO << "SModelS database contains " <<nResults<<" results."<< Messenger::Endl;
    messenger << Messenger::INFO << "SModelS database uses "<<_txNamesWithResults.size()<<" TxNames."<<Messenger::Endl;

    auto tdict = boost::python::import("smodels.tools.tdict");

    auto dictionary = tdict.attr( "txnames" );

    auto iter = dictionary.attr("itervalues")();

    for ( int i=0; i< boost::python::len(dictionary); ++i ) {

        std::string name = boost::python::extract<std::string> ( iter.attr("next")() );

        _txNames.insert( name  );

    }

    messenger << Messenger::INFO << "SModelS knows "<<_txNames.size()<<" TxNames."<<Messenger::Endl;

    _txNames.insert( "None" );

    for ( auto txName : _txNames ) {

        AddOutput( "MissingWeight_" + txName );

    }

}

Fittino::SModelSCalculator::~SModelSCalculator() {

}

void Fittino::SModelSCalculator::CalculatePredictions() {

    for( auto txName : _txNames ) {

        SetOutput( "MissingWeight_" + txName, 0  );

    }

    _crossSections_LO->Execute();
    _crossSections_NLL->Execute();

    auto result = _testPoints( _fileList, _fileName, "results", _parser, _databaseVersion, _listOfExpRes, 900, false, _parameterFile );

    ReadXML();


}

void Fittino::SModelSCalculator::ReadXML() {

    boost::property_tree::ptree ptree;

    boost::property_tree::read_xml( _xmlFile,
                                    ptree,
                                    boost::property_tree::xml_parser::trim_whitespace |
                                    boost::property_tree::xml_parser::no_comments );

    _rValue = 0;

    double ul, tp, r;

    for ( const auto res : ptree.get_child("smodelsOutput.ExptRes_List") ){

         ul = res.second.get<double>( "upper_limit_fb" );
         tp = res.second.get<double>( "theory_prediction_fb" );
         r = tp / ul;

        if ( r > _rValue ) _rValue = r;

    }

    for( auto node : ptree.get_child( "smodelsOutput.Missing_Topologies" ) ) {

        std::string txName = node.first;

        if ( _txNames.count( txName ) == 0 ) {

            throw LogicException("txName " + txName + " appears in Missing_Topologies in xml file but is unknown." );

        }

        SetOutput( "MissingWeight_" + txName, node.second.get<double>("TopoWeight_pb")  );

    }

}

void Fittino::SModelSCalculator::Initialize() {


}
