#include <boost/python.hpp>
#include <Python.h>
#include <boost/property_tree/ptree.hpp>
#include <boost/property_tree/xml_parser.hpp>
#include <iostream>
#include <CalculatorException.h>
#include <LogicException.h>
#include "Executor.h"
#include "SModelSCalculator.h"
#include "Messenger.h"

Fittino::SModelSCalculator::SModelSCalculator(const ModelBase *model, const boost::property_tree::ptree &ptree)
        : CalculatorBase(model, &ptree) {

    AddOutput( "RValue", _rValue );
    AddOutput( "DecompositionStatus", _decompositionStatus );
    AddOutput( "FileStatus", _fileStatus );

    AddFile( "results" );

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

    _inputFiles = getAllInputFiles( _fileName );

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

    _numberOfMissingModelsConsidered =  ptree.get<unsigned int>( "NumberOfUnusedModels", 10 );
    _missingModels_TxNames.resize( _numberOfMissingModelsConsidered );
    _missingModels_Brackets.resize( _numberOfMissingModelsConsidered );
    _missingModels_Weights_Total.resize( _numberOfMissingModelsConsidered );
    _missingModels_Fractions_OutsideGrid.resize( _numberOfMissingModelsConsidered );
    _missingModels_Fractions_InsideGrid.resize( _numberOfMissingModelsConsidered );
            
    for( unsigned int i = 0; i< _numberOfMissingModelsConsidered ; ++i ) {
        
            AddStringVariable("UnusedModel_" + std::to_string(i) + "_Bracket", _missingModels_Brackets[i] );
            AddStringVariable("UnusedModel_" + std::to_string(i) + "_TxName", _missingModels_TxNames[i] );
            AddOutput( "UnusedModel_" + std::to_string(i) + "_Weight", _missingModels_Weights_Total[i]  );
            AddOutput( "UnusedModel" + std::to_string(i) + "_FractionMissing", _missingModels_Fractions_InsideGrid[i]  );
            AddOutput( "UnusedModel_" + std::to_string(i) + "_FractionOutsideGrid", _missingModels_Fractions_OutsideGrid[i]  );
        
    }
            
    _constraintsMissing_NumberConsidered = 10;
    _constraintsMissing_Weights.resize( _constraintsMissing_NumberConsidered );
    _constraintsMissing_Brackets.resize( _constraintsMissing_NumberConsidered );
            
    for( unsigned int i = 0; i< _constraintsMissing_NumberConsidered ; ++i ) {
        
        AddOutput( "MissingConstraint_" + std::to_string(i) + "_Weight", _constraintsMissing_Weights[i]  );
        AddStringVariable( "MissingConstraint_" + std::to_string(i) + "_Bracket", _constraintsMissing_Brackets[i] );

    }
            
    _constraintsOutsideGrid_NumberConsidered = 10;
    _constraintsOutsideGrid_Weights.resize( _constraintsOutsideGrid_NumberConsidered );
    _constraintsOutsideGrid_Brackets.resize( _constraintsOutsideGrid_NumberConsidered );

    for( unsigned int i = 0; i< _constraintsOutsideGrid_NumberConsidered ; ++i ) {
                
        AddOutput( "ConstraintOutsideGrid_" + std::to_string(i) + "_Weight", _constraintsOutsideGrid_Weights[i]  );
        AddStringVariable("ConstraintOutsideGrid_" + std::to_string(i) + "_Bracket", _constraintsOutsideGrid_Brackets[i] );
                
    }

    AddOutput( "NumberOfUnusedModels", _numberOfMissingModelsDetermined );
    AddOutput( "NumberOfMissingConstraints", _constraintsMissing_NumberDetermined );
    AddOutput( "NumberOfConstraintsOutsideGrid", _constraintsOutsideGrid_NumberDetermined );

}

Fittino::SModelSCalculator::~SModelSCalculator() {

}

void Fittino::SModelSCalculator::CalculatePredictions() {
    
    for( unsigned int iMissingModel = 0; iMissingModel < _numberOfMissingModelsConsidered; ++iMissingModel ) {

        _missingModels_TxNames.at(iMissingModel) = "";
        _missingModels_Brackets.at(iMissingModel) = "";
        
        _missingModels_Weights_Total.at(iMissingModel) = 0;
        _missingModels_Fractions_InsideGrid.at(iMissingModel) = 0;
        _missingModels_Fractions_OutsideGrid.at(iMissingModel) = 0;
        
    }
    
    for( unsigned int i = 0; i < _constraintsMissing_NumberConsidered; ++i ) {
    
        _constraintsMissing_Brackets.at( i ) = "";
        _constraintsMissing_Weights.at( i ) = 0;
        
    }
    
    for( unsigned int i = 0; i < _constraintsOutsideGrid_NumberConsidered; ++i ) {
        
        _constraintsOutsideGrid_Brackets.at( i ) = "";
        _constraintsOutsideGrid_Weights.at( i ) = 0;
        
    }

    _crossSections_LO->Execute();
    _crossSections_NLL->Execute();
    
    // [] returns a boost::python::proxy and needs to be converted to a boost::python::object
    boost::python::object fileList = _inputFiles[0];
    boost::python::object inDir = _inputFiles[1];
    
    auto result = _testPoints( fileList, inDir, "results", _parser, _databaseVersion, _listOfExpRes, 900, true, _parameterFile );
    
    if ( !result ) {
        
        throw CalculatorException( _name, "SMODELS_NONE" );
        
    }

    ReadXML();
    ReadMissingConstraints();
    ReadConstraintsOutsideGrid();

}

void Fittino::SModelSCalculator::ReadXML() {

    boost::property_tree::ptree ptree;

    boost::property_tree::read_xml( _xmlFile,
                                    ptree,
                                    boost::property_tree::xml_parser::trim_whitespace |
                                    boost::property_tree::xml_parser::no_comments );
    
    ptree = ptree.get_child( "smodelsOutput" );
    
    _fileStatus = ptree.get<int>( "OutputStatus.file_status" );
    
    if( _fileStatus != 1 ) {
        
        throw CalculatorException( _name, "SMODELS_FILESTATUS" );
        
    }
    
    _decompositionStatus = ptree.get<int>( "OutputStatus.decomposition_status" );
    
    if( _decompositionStatus != 1 ) {
        
        throw CalculatorException( _name, "SMODELS_DECOMPOSITIONSTATUS" );
        
    }

    _rValue = 0;

    double ul, tp, r;
    
    if ( ptree.count("ExptRes_List" ) ) {
        
        for ( const auto res : ptree.get_child( "ExptRes_List" ) ){
        
            ul = res.second.get<double>( "upper_limit_fb" );
            tp = res.second.get<double>( "theory_prediction_fb" );
            r = tp / ul;

            if ( r > _rValue ) _rValue = r;

        }
        
    }

    unsigned int iModel = 0;

    for( auto node : ptree.get_child( "Missing_Topologies" ) ) {

        std::string txName = node.first;
        double weight = node.second.get<double>("TopoWeight_pb");
        std::string bracket = node.second.get<std::string>("Finalstate");
        double fractionOutsideGrid = node.second.get<double>("Outside_grid_pb") / weight;
        double fractionInsideGrid = node.second.get<double>("No_OS_pb") / weight;

        if( iModel < _numberOfMissingModelsConsidered ) {

            _missingModels_TxNames.at(iModel) = txName;
            _missingModels_Brackets.at(iModel) = bracket;

            _missingModels_Weights_Total.at(iModel) = weight;
            _missingModels_Fractions_InsideGrid.at(iModel) = fractionInsideGrid;
            _missingModels_Fractions_OutsideGrid.at(iModel) = fractionOutsideGrid;

        }

        ++iModel;

    }

    _numberOfMissingModelsDetermined = iModel;
    
}

void Fittino::SModelSCalculator::Initialize() {


}

void Fittino::SModelSCalculator::ReadMissingConstraints() {
    
    boost::property_tree::ptree ptree;
    
    // TODO: avoid reading the file twice
    
    boost::property_tree::read_xml( _xmlFile,
                                   ptree,
                                   boost::property_tree::xml_parser::trim_whitespace |
                                   boost::property_tree::xml_parser::no_comments );
    
    ptree = ptree.get_child( "smodelsOutput" );

    unsigned int iConstraint = 0;
    
    for( auto node : ptree.get_child( "Missing_Constraints.Missing.Constraint_List" ) ) {
        
        if( node.first != "Constraint" ) throw LogicException("Expected node Constraint in SModelS xml file.");
        
        if( iConstraint < _constraintsMissing_NumberConsidered ) {
            
            _constraintsMissing_Brackets.at( iConstraint ) = node.second.get<std::string>( "FinalState" );
            _constraintsMissing_Weights.at( iConstraint ) = node.second.get<double>( "Weight_pb" );

        }
        
        ++iConstraint;
        
    }
    
    _constraintsMissing_NumberDetermined = iConstraint;
    
}


void Fittino::SModelSCalculator::ReadConstraintsOutsideGrid() {
    
    boost::property_tree::ptree ptree;
    
    // TODO: avoid reading the file twice
    
    boost::property_tree::read_xml( _xmlFile,
                                   ptree,
                                   boost::property_tree::xml_parser::trim_whitespace |
                                   boost::property_tree::xml_parser::no_comments );
    
    ptree = ptree.get_child( "smodelsOutput" );

    unsigned int iConstraint = 0;
    
    for( auto node : ptree.get_child( "Missing_Constraints.Outside_Grid.Constraint_List" ) ) {
        
        if( node.first != "Constraint" ) throw LogicException("Expected node Constraint in SModelS xml file.");
        
        if( iConstraint < _constraintsOutsideGrid_NumberConsidered ) {
            
            _constraintsOutsideGrid_Brackets.at( iConstraint ) = node.second.get<std::string>( "FinalState" );
            _constraintsOutsideGrid_Weights.at( iConstraint ) = node.second.get<double>( "Weight_pb" );
            
        }
        
        ++iConstraint;
        
    }
    
    _constraintsOutsideGrid_NumberDetermined = iConstraint;
    
}
