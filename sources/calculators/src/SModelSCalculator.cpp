#include <boost/python.hpp>
#include <boost/property_tree/ptree.hpp>
#include <boost/property_tree/xml_parser.hpp>
#include <Python.h>
#include "Executor.h"
#include "SModelSCalculator.h"

Fittino::SModelSCalculator::SModelSCalculator(const ModelBase *model, const boost::property_tree::ptree &ptree)
        : CalculatorBase(model, &ptree) {

    std::string exename = "SModelSToolsExecutable";

#ifdef SModelSTools_EXECUTABLE

    std::string executable = ptree.get<std::string>( exename, SModelSTools_EXECUTABLE );

#else

    if ( ptree.count(exename) == 0 ) {

        throw ConfigurationException("SModelSTools was not found. Please set " + exename + " in the input file.");

    }

    std::string executable = ptree.get<std::string>(exename);

#endif

    std::string fileName = ptree.get<std::string>( "FileName" );

    _xmlFile = "results/" + fileName + ".xml";

    std::string parameterFile = ptree.get<std::string>( "ParameterFile" );

    _crossSections_LO = new Executor( executable, "smodelsTools.py" );
    _crossSections_LO->AddArgument("xseccomputer");
    _crossSections_LO->AddArgument("-s");
    _crossSections_LO->AddArgument("8");
    _crossSections_LO->AddArgument("13");
    _crossSections_LO->AddArgument("-e");
    _crossSections_LO->AddArgument("10000");
    _crossSections_LO->AddArgument("-p");
    _crossSections_LO->AddArgument("-f");
    _crossSections_LO->AddArgument(fileName);

    _crossSections_NLL = new Executor( executable, "smodelsTools.py" );
    _crossSections_NLL->AddArgument("xseccomputer");
    _crossSections_NLL->AddArgument("-s");
    _crossSections_NLL->AddArgument("8");
    _crossSections_NLL->AddArgument("13");
    _crossSections_NLL->AddArgument("-p");
    _crossSections_NLL->AddArgument("-N");
    _crossSections_NLL->AddArgument("-O");
    _crossSections_NLL->AddArgument("-f");
    _crossSections_NLL->AddArgument(fileName);

    Py_Initialize();

    PyRun_SimpleString(("parameterFile = '" + parameterFile + "'").c_str());
    PyRun_SimpleString("from smodels.tools import modelTester");
    PyRun_SimpleString("parser = modelTester.getParameters( parameterFile )");
    PyRun_SimpleString("database, databaseVersion = modelTester.loadDatabase(parser, None )");
    PyRun_SimpleString("listOfExpRes = modelTester.loadDatabaseResults(parser, database)");
    PyRun_SimpleString("print '[smodels.cpp] %d experimental results found.' % len(listOfExpRes) ");
    PyRun_SimpleString(("fileName = '" + fileName + "'").c_str());
    PyRun_SimpleString("fileList = modelTester.getAllInputFiles( fileName )");

}

Fittino::SModelSCalculator::~SModelSCalculator() {

}

void Fittino::SModelSCalculator::CalculatePredictions() {

    _crossSections_LO->Execute();
    _crossSections_NLL->Execute();

    PyRun_SimpleString(
            "modelTester.testPoints( fileList, fileName, 'results', parser, databaseVersion, listOfExpRes, 900, False, parameterFile )");


    ReadXML();


}

void Fittino::SModelSCalculator::ReadXML() {

    boost::property_tree::ptree ptree;

    boost::property_tree::read_xml( _xmlFile,
                                    ptree,
                                    boost::property_tree::xml_parser::trim_whitespace |
                                    boost::property_tree::xml_parser::no_comments );

}

void Fittino::SModelSCalculator::Initialize() {


}
