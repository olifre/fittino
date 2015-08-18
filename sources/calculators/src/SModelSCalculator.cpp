/* $Id: SModelSCalculator.cpp 2528 2015-04-07 10:54:29Z range@PHYSIK.UNI-BONN.DE $ */

/******************************************************************************* 
 *                                                                              *
 * Project     Fittino - A SUSY Parameter Fitting Package                       *    
 *                                                                              * 
 * File        SModelSCalculator.cpp                                            *                  
 * Description: Wrapper around SModelS                                          *                                                    
 * Authors:     Nanette Range                                                   *
 *                                                                              *
 * Licence     This program is free software; you can redistribute it and/or    *    
 *             modify it under the terms of the GNU General Public License as   *        
 *             published by the Free Software Foundation; either version 3 of   *          
 *             the License, or (at your option) any later version.              *
 *                                                                              *
 *******************************************************************************/

#include <Python.h>
#include <boost/lexical_cast.hpp>
#include <boost/python.hpp>
#include <fstream>
#include <iostream>
#include <string>
#include <boost/algorithm/string.hpp>
#include <math.h>

#include "SimplePrediction.h"
#include "SModelSCalculator.h"
#include "Executor.h"

Fittino::SModelSCalculator::SModelSCalculator( const ModelBase* model, const boost::property_tree::ptree& ptree)
    : CalculatorBase( model, &ptree ) {

  AddQuantity( new SimplePrediction( "r", "", _r ));
  AddQuantity( new SimplePrediction( "chi2", "", _Chi2));

  AddOutput( "ATLAS_SUSY_2013_02_T1theo" );
  AddOutput( "ATLAS_SUSY_2013_02_T1obs" );
  AddOutput( "ATLAS_SUSY_2013_02_T1exp" );
  AddOutput( "ATLAS_SUSY_2013_02_T1chi2" );
  AddOutput( "ATLAS_SUSY_2013_05_T2bbtheo" );
  AddOutput( "ATLAS_SUSY_2013_05_T2bbobs" );
  AddOutput( "ATLAS_SUSY_2013_05_T2bbexp" );
  AddOutput( "ATLAS_SUSY_2013_05_T2bbchi2" );
  AddOutput( "ATLAS_SUSY_2013_11_TSlepSleptheo" );
  AddOutput( "ATLAS_SUSY_2013_11_TSlepSlepobs" );
  AddOutput( "ATLAS_SUSY_2013_11_TSlepSlepexp" );
  AddOutput( "ATLAS_SUSY_2013_11_TSlepSlepchi2" );
  AddOutput( "ATLAS_SUSY_2013_12_TChiWHtheo" );
  AddOutput( "ATLAS_SUSY_2013_12_TChiWHobs" );
  AddOutput( "ATLAS_SUSY_2013_12_TChiWHexp" );
  AddOutput( "ATLAS_SUSY_2013_12_TChiWHchi2" );
  AddOutput( "ATLAS_SUSY_2013_14_TStauStautheo" );
  AddOutput( "ATLAS_SUSY_2013_14_TStauStauobs" );
  AddOutput( "ATLAS_SUSY_2013_14_TStauStauexp" );
  AddOutput( "ATLAS_SUSY_2013_14_TStauStauchi2" );
  AddOutput( "ATLAS_SUSY_2013_15_T2bbWWtheo" );
  AddOutput( "ATLAS_SUSY_2013_15_T2bbWWobs" );
  AddOutput( "ATLAS_SUSY_2013_15_T2bbWWexp" );
  AddOutput( "ATLAS_SUSY_2013_15_T2bbWWchi2" );
  AddOutput( "ATLAS_SUSY_2013_19_T2tttheo" );
  AddOutput( "ATLAS_SUSY_2013_19_T2ttobs" );
  AddOutput( "ATLAS_SUSY_2013_19_T2ttexp" );
  AddOutput( "ATLAS_SUSY_2013_19_T2ttchi2" );
  AddOutput( "ATLAS_SUSY_2013_19_T2bbWWtheo" );
  AddOutput( "ATLAS_SUSY_2013_19_T2bbWWobs" );
  AddOutput( "ATLAS_SUSY_2013_19_T2bbWWexp" );
  AddOutput( "ATLAS_SUSY_2013_19_T2bbWWchi2" );
  AddOutput( "ATLAS_CONF_2013_061_T1bbbbtheo" );
  AddOutput( "ATLAS_CONF_2013_061_T1bbbbobs" );
  AddOutput( "ATLAS_CONF_2013_061_T1bbbbexp" );
  AddOutput( "ATLAS_CONF_2013_061_T1bbbbchi2" );
  AddOutput( "ATLAS_CONF_2013_065_T2tttheo" );
  AddOutput( "ATLAS_CONF_2013_065_T2ttobs" );
  AddOutput( "ATLAS_CONF_2013_065_T2ttexp" );
  AddOutput( "ATLAS_CONF_2013_065_T2ttchi2" );
  AddOutput( "CMS_SUS_12_024_T1bbbbtheo" );
  AddOutput( "CMS_SUS_12_024_T1bbbbobs" );
  AddOutput( "CMS_SUS_12_024_T1bbbbexp" );
  AddOutput( "CMS_SUS_12_024_T1bbbbchi2" );
  AddOutput( "CMS_SUS_12_024_T5tttttheo" );
  AddOutput( "CMS_SUS_12_024_T5ttttobs" );
  AddOutput( "CMS_SUS_12_024_T5ttttexp" );
  AddOutput( "CMS_SUS_12_024_T5ttttchi2" );
  AddOutput( "CMS_SUS_12_028_T1theo" );
  AddOutput( "CMS_SUS_12_028_T1obs" );
  AddOutput( "CMS_SUS_12_028_T1exp" );
  AddOutput( "CMS_SUS_12_028_T1chi2" );
  AddOutput( "CMS_SUS_12_028_T1bbbbtheo" );
  AddOutput( "CMS_SUS_12_028_T1bbbbobs" );
  AddOutput( "CMS_SUS_12_028_T1bbbbexp" );
  AddOutput( "CMS_SUS_12_028_T1bbbbchi2" );
  AddOutput( "CMS_SUS_13_006_TChiWZtheo" );
  AddOutput( "CMS_SUS_13_006_TChiWZobs" );
  AddOutput( "CMS_SUS_13_006_TChiWZexp" );
  AddOutput( "CMS_SUS_13_006_TChiWZchi2" );
  AddOutput( "CMS_SUS_13_006_TSlepSleptheo" );
  AddOutput( "CMS_SUS_13_006_TSlepSlepobs" );
  AddOutput( "CMS_SUS_13_006_TSlepSlepexp" );
  AddOutput( "CMS_SUS_13_006_TSlepSlepchi2" );
  AddOutput( "CMS_SUS_13_006_TChiChipmSlepLtheo" );
  AddOutput( "CMS_SUS_13_006_TChiChipmSlepLobs" );
  AddOutput( "CMS_SUS_13_006_TChiChipmSlepLexp" );
  AddOutput( "CMS_SUS_13_006_TChiChipmSlepLchi2" );
  AddOutput( "CMS_SUS_13_006_TChiChipmSlepStautheo" );
  AddOutput( "CMS_SUS_13_006_TChiChipmSlepStauobs" );
  AddOutput( "CMS_SUS_13_006_TChiChipmSlepStauexp" );
  AddOutput( "CMS_SUS_13_006_TChiChipmSlepStauchi2" );
  AddOutput( "CMS_SUS_13_011_T6bbWWtheo" );
  AddOutput( "CMS_SUS_13_011_T6bbWWobs" );
  AddOutput( "CMS_SUS_13_011_T6bbWWexp" );
  AddOutput( "CMS_SUS_13_011_T6bbWWchi2" );
  AddOutput( "CMS_SUS_13_012_T1theo" );
  AddOutput( "CMS_SUS_13_012_T1obs" );
  AddOutput( "CMS_SUS_13_012_T1exp" );
  AddOutput( "CMS_SUS_13_012_T1chi2" );
  AddOutput( "CMS_PAS_SUS_13_008_T6ttWWtheo" );
  AddOutput( "CMS_PAS_SUS_13_008_T6ttWWobs" );
  AddOutput( "CMS_PAS_SUS_13_008_T6ttWWexp" );
  AddOutput( "CMS_PAS_SUS_13_008_T6ttWWchi2" );
  AddOutput( "CMS_PAS_SUS_13_018_T2bbtheo" );
  AddOutput( "CMS_PAS_SUS_13_018_T2bbobs" );
  AddOutput( "CMS_PAS_SUS_13_018_T2bbexp" );
  AddOutput( "CMS_PAS_SUS_13_018_T2bbchi2" );
  AddOutput( "CMS_PAS_SUS_13_019_T1theo" );
  AddOutput( "CMS_PAS_SUS_13_019_T1obs" );
  AddOutput( "CMS_PAS_SUS_13_019_T1exp" );
  AddOutput( "CMS_PAS_SUS_13_019_T1chi2" );
  AddOutput( "CMS_PAS_SUS_13_019_T1bbbbtheo" );
  AddOutput( "CMS_PAS_SUS_13_019_T1bbbbobs" );
  AddOutput( "CMS_PAS_SUS_13_019_T1bbbbexp" );
  AddOutput( "CMS_PAS_SUS_13_019_T1bbbbchi2" );
  AddOutput( "CMS_PAS_SUS_13_019_T2bbtheo" );
  AddOutput( "CMS_PAS_SUS_13_019_T2bbobs" );
  AddOutput( "CMS_PAS_SUS_13_019_T2bbexp" );
  AddOutput( "CMS_PAS_SUS_13_019_T2bbchi2" );
  AddOutput( "CMS_PAS_SUS_14_011_T1bbbbtheo" );
  AddOutput( "CMS_PAS_SUS_14_011_T1bbbbobs" );
  AddOutput( "CMS_PAS_SUS_14_011_T1bbbbexp" );
  AddOutput( "CMS_PAS_SUS_14_011_T1bbbbchi2" );
  AddOutput( "CMS_SUS_12_024_T1tttttheo" );
  AddOutput( "CMS_SUS_12_024_T1ttttobs" );
  AddOutput( "CMS_SUS_12_024_T1ttttexp" );
  AddOutput( "CMS_SUS_12_024_T1ttttchi2" );
  AddOutput( "CMS_SUS_12_028_T1tttttheo" );
  AddOutput( "CMS_SUS_12_028_T1ttttobs" );
  AddOutput( "CMS_SUS_12_028_T1ttttexp" );
  AddOutput( "CMS_SUS_12_028_T1ttttchi2" );
  AddOutput( "CMS_SUS_12_028_T2theo" );
  AddOutput( "CMS_SUS_12_028_T2obs" );
  AddOutput( "CMS_SUS_12_028_T2exp" );
  AddOutput( "CMS_SUS_12_028_T2chi2" );
  AddOutput( "CMS_SUS_12_028_T2bbtheo" );
  AddOutput( "CMS_SUS_12_028_T2bbobs" );
  AddOutput( "CMS_SUS_12_028_T2bbexp" );
  AddOutput( "CMS_SUS_12_028_T2bbchi2" );
  AddOutput( "ATLAS_CONF_2012_105_T1tttttheo" );
  AddOutput( "ATLAS_CONF_2012_105_T1ttttobs" );
  AddOutput( "ATLAS_CONF_2012_105_T1ttttexp" );
  AddOutput( "ATLAS_CONF_2012_105_T1ttttchi2" );
  AddOutput( "ATLAS_CONF_2013_007_T1tttttheo" );
  AddOutput( "ATLAS_CONF_2013_007_T1ttttobs" );
  AddOutput( "ATLAS_CONF_2013_007_T1ttttexp" );
  AddOutput( "ATLAS_CONF_2013_007_T1ttttchi2" );
  AddOutput( "ATLAS_SUSY_2013_12_TChiWZtheo" );
  AddOutput( "ATLAS_SUSY_2013_12_TChiWZobs" );
  AddOutput( "ATLAS_SUSY_2013_12_TChiWZexp" );
  AddOutput( "ATLAS_SUSY_2013_12_TChiWZchi2" );
  AddOutput( "ATLAS_SUSY_2013_11_TChiWZtheo" );
  AddOutput( "ATLAS_SUSY_2013_11_TChiWZobs" );
  AddOutput( "ATLAS_SUSY_2013_11_TChiWZexp" );
  AddOutput( "ATLAS_SUSY_2013_11_TChiWZchi2" );
  AddOutput( "ATLAS_SUSY_2013_15_T2tttheo" );
  AddOutput( "ATLAS_SUSY_2013_15_T2ttobs" );
  AddOutput( "ATLAS_SUSY_2013_15_T2ttexp" );
  AddOutput( "ATLAS_SUSY_2013_15_T2ttchi2" );
  AddOutput( "CMS_SUS_13_012_T1tttttheo" );
  AddOutput( "CMS_SUS_13_012_T1ttttobs" );
  AddOutput( "CMS_SUS_13_012_T1ttttexp" );
  AddOutput( "CMS_SUS_13_012_T1ttttchi2" );
  AddOutput( "CMS_SUS_13_012_T2theo" );
  AddOutput( "CMS_SUS_13_012_T2obs" );
  AddOutput( "CMS_SUS_13_012_T2exp" );
  AddOutput( "CMS_SUS_13_012_T2chi2" );
  AddOutput( "CMS_SUS_13_013_T1tttttheo" );
  AddOutput( "CMS_SUS_13_013_T1ttttobs" );
  AddOutput( "CMS_SUS_13_013_T1ttttexp" );
  AddOutput( "CMS_SUS_13_013_T1ttttchi2" );
  AddOutput( "ATLAS_SUSY_2013_19_T6bbWWtheo" );
  AddOutput( "ATLAS_SUSY_2013_19_T6bbWWobs" );
  AddOutput( "ATLAS_SUSY_2013_19_T6bbWWexp" ); 
  AddOutput( "ATLAS_SUSY_2013_19_T6bbWWchi2" );
  AddOutput( "CMS_SUS_13_011_T2tttheo" );
  AddOutput( "CMS_SUS_13_011_T2ttobs" );
  AddOutput( "CMS_SUS_13_011_T2ttexp" );
  AddOutput( "CMS_SUS_13_011_T2ttchi2" );
  AddOutput( "ATLAS_CONF_2013_024_T2tttheo" );
  AddOutput( "ATLAS_CONF_2013_024_T2ttobs" );
  AddOutput( "ATLAS_CONF_2013_024_T2ttexp" );
  AddOutput( "ATLAS_CONF_2013_024_T2ttchi2" );
  AddOutput( "CMS_PAS_SUS_13_019_T1tttttheo" );
  AddOutput( "CMS_PAS_SUS_13_019_T1ttttobs" );
  AddOutput( "CMS_PAS_SUS_13_019_T1ttttexp" );
  AddOutput( "CMS_PAS_SUS_13_019_T1ttttchi2" );
  AddOutput( "CMS_PAS_SUS_13_019_T2tttheo" );
  AddOutput( "CMS_PAS_SUS_13_019_T2ttobs" );
  AddOutput( "CMS_PAS_SUS_13_019_T2ttexp" );
  AddOutput( "CMS_PAS_SUS_13_019_T2ttchi2" ); 
  AddOutput( "CMS_PAS_SUS_13_019_T2theo" );
  AddOutput( "CMS_PAS_SUS_13_019_T2obs" );
  AddOutput( "CMS_PAS_SUS_13_019_T2exp" );
  AddOutput( "CMS_PAS_SUS_13_019_T2chi2" );
  AddOutput( "CMS_SUS_13_002_T1tttttheo" );
  AddOutput( "CMS_SUS_13_002_T1ttttobs" );
  AddOutput( "CMS_SUS_13_002_T1ttttexp" );
  AddOutput( "CMS_SUS_13_002_T1ttttchi2" );
  AddOutput( "ATLAS_SUSY_2013_04_T1tttttheo" );
  AddOutput( "ATLAS_SUSY_2013_04_T1ttttobs" );
  AddOutput( "ATLAS_SUSY_2013_04_T1ttttexp" );
  AddOutput( "ATLAS_SUSY_2013_04_T1ttttchi2" );
  AddOutput( "ATLAS_SUSY_2013_02_T2theo" );
  AddOutput( "ATLAS_SUSY_2013_02_T2obs" );
  AddOutput( "ATLAS_SUSY_2013_02_T2exp" );
  AddOutput( "ATLAS_SUSY_2013_02_T2chi2" );
  AddOutput( "CMS_PAS_SUS_13_008_T1tttttheo" );
  AddOutput( "CMS_PAS_SUS_13_008_T1ttttobs" );
  AddOutput( "CMS_PAS_SUS_13_008_T1ttttexp" );
  AddOutput( "CMS_PAS_SUS_13_008_T1ttttchi2" );
  AddOutput( "CMS_SUS_13_007_T1tttttheo" );
  AddOutput( "CMS_SUS_13_007_T1ttttobs" );
  AddOutput( "CMS_SUS_13_007_T1ttttexp" );
  AddOutput( "CMS_SUS_13_007_T1ttttchi2" );
  AddOutput( "CMS_PAS_SUS_14_011_T2tttheo" );
  AddOutput( "CMS_PAS_SUS_14_011_T2ttobs" );
  AddOutput( "CMS_PAS_SUS_14_011_T2ttexp" );
  AddOutput( "CMS_PAS_SUS_14_011_T2ttchi2" );
  AddOutput( "CMS_PAS_SUS_14_011_T1tttttheo" );
  AddOutput( "CMS_PAS_SUS_14_011_T1ttttobs" );
  AddOutput( "CMS_PAS_SUS_14_011_T1ttttexp" );
  AddOutput( "CMS_PAS_SUS_14_011_T1ttttchi2" );
  AddOutput( "CMS_PAS_SUS_13_016_T1tttttheo" );
  AddOutput( "CMS_PAS_SUS_13_016_T1ttttobs" );
  AddOutput( "CMS_PAS_SUS_13_016_T1ttttexp" );
  AddOutput( "CMS_PAS_SUS_13_016_T1ttttchi2" );
  AddOutput( "ATLAS_CONF_2013_061_T1tttttheo" );
  AddOutput( "ATLAS_CONF_2013_061_T1ttttobs" );
  AddOutput( "ATLAS_CONF_2013_061_T1ttttexp" );
  AddOutput( "ATLAS_CONF_2013_061_T1ttttchi2" );
 
}
Fittino::SModelSCalculator::~SModelSCalculator() {

}

void Fittino::SModelSCalculator::CalculatePredictions() {

  std::string inputrunTools = "SPheno.spc";

  Executor executorTools( "/lustre/fittino/group/external/SL6/SModelS/smodels-v1.0.2/runTools.py", "runTools" );
  executorTools.AddArgument( "xseccomputer" );
  executorTools.AddArgument( "-f" );
  executorTools.AddArgument( inputrunTools );
  executorTools.AddArgument( "-p" );
  executorTools.AddArgument( "-N" );
  executorTools.Execute();
  
  std::string inputSModelS = "SPheno.spc";
  std::string parameterfile = "/lustre/fittino/group/external/SL6/SModelS/smodels-v1.0.2/etc/parameters_default.ini";
  std::string outputfile = "/lustre/user/range/fittino/bin/summary.txt";

  Executor executorSModelS( "/lustre/fittino/group/external/SL6/SModelS/smodels-v1.0.2/runSModelSchi2.py", "runSModelS");
  executorSModelS.AddArgument( "-f" );
  executorSModelS.AddArgument( inputSModelS );
  executorSModelS.AddArgument( "-p" );
  executorSModelS.AddArgument( parameterfile );
  executorSModelS.AddArgument( "-o" );
  executorSModelS.AddArgument( outputfile );
  executorSModelS.Execute();

  //Py_Initialize();
  
  // PyObject* sysPath = PySys_GetObject("path");
  //PyList_Insert( sysPath, 0, PyString_FromString("/lustre/fittino/group/external/Python_2.7/lib/python2.7/site_packages"));
  //PyList_Insert( sysPath, 0, PyString_FromString("/lustre/fittino/group/external/SL6/SModelS/smodels_v1.0.2"));

  //boost::python::object main_module = boost::python::import("__main__");
  //boost::python::object main_namespace = main_module.attr("__dict__"); 
  
  //boost::python::str filename = "/lustre/fittino/group/external/SL6/SModelS/smodels-v1.0.2/runSModelS.py";
  //try{
  //boost::python::object SModelS = boost::python::exec_file( filename, main_namespace, main_namespace);  
  //}
  //catch(boost::python::error_already_set& e)
  //{
  //PyErr_Print();
  //}

  //Py_Finalize();
  
  _value0 = 0.00;
  _value1 = -1.00;

  SetOutput( "ATLAS_SUSY_2013_02_T1theo", _value1 );
  SetOutput( "ATLAS_SUSY_2013_02_T1obs", _value1 );
  SetOutput( "ATLAS_SUSY_2013_02_T1exp", _value1 );
  SetOutput( "ATLAS_SUSY_2013_02_T1chi2", _value0 );
  SetOutput( "ATLAS_SUSY_2013_05_T2bbtheo", _value1 );
  SetOutput( "ATLAS_SUSY_2013_05_T2bbobs", _value1 );
  SetOutput( "ATLAS_SUSY_2013_05_T2bbexp", _value1 );
  SetOutput( "ATLAS_SUSY_2013_05_T2bbchi2", _value0 );
  SetOutput( "ATLAS_SUSY_2013_11_TSlepSleptheo", _value1 );
  SetOutput( "ATLAS_SUSY_2013_11_TSlepSlepobs", _value1 );
  SetOutput( "ATLAS_SUSY_2013_11_TSlepSlepexp", _value1 );
  SetOutput( "ATLAS_SUSY_2013_11_TSlepSlepchi2", _value0 );
  SetOutput( "ATLAS_SUSY_2013_12_TChiWHtheo", _value1 );
  SetOutput( "ATLAS_SUSY_2013_12_TChiWHobs", _value1 );
  SetOutput( "ATLAS_SUSY_2013_12_TChiWHexp", _value1 );
  SetOutput( "ATLAS_SUSY_2013_12_TChiWHchi2", _value0 );
  SetOutput( "ATLAS_SUSY_2013_14_TStauStautheo", _value1 );
  SetOutput( "ATLAS_SUSY_2013_14_TStauStauobs", _value1 );
  SetOutput( "ATLAS_SUSY_2013_14_TStauStauexp", _value1 );
  SetOutput( "ATLAS_SUSY_2013_14_TStauStauchi2", _value0 );
  SetOutput( "ATLAS_SUSY_2013_15_T2bbWWtheo", _value1 );
  SetOutput( "ATLAS_SUSY_2013_15_T2bbWWobs", _value1 );
  SetOutput( "ATLAS_SUSY_2013_15_T2bbWWexp", _value1 );
  SetOutput( "ATLAS_SUSY_2013_15_T2bbWWchi2", _value0 );
  SetOutput( "ATLAS_SUSY_2013_19_T2tttheo", _value1 );
  SetOutput( "ATLAS_SUSY_2013_19_T2ttobs", _value1 );
  SetOutput( "ATLAS_SUSY_2013_19_T2ttexp", _value1 );
  SetOutput( "ATLAS_SUSY_2013_19_T2ttchi2", _value0 );
  SetOutput( "ATLAS_SUSY_2013_19_T2bbWWtheo", _value1 );
  SetOutput( "ATLAS_SUSY_2013_19_T2bbWWobs", _value1 );
  SetOutput( "ATLAS_SUSY_2013_19_T2bbWWexp", _value1 );
  SetOutput( "ATLAS_SUSY_2013_19_T2bbWWchi2", _value0 );
  SetOutput( "ATLAS_CONF_2013_061_T1bbbbtheo", _value1 );
  SetOutput( "ATLAS_CONF_2013_061_T1bbbbobs", _value1 );
  SetOutput( "ATLAS_CONF_2013_061_T1bbbbexp", _value1 );
  SetOutput( "ATLAS_CONF_2013_061_T1bbbbchi2", _value0 );
  SetOutput( "ATLAS_CONF_2013_065_T2tttheo", _value1 );
  SetOutput( "ATLAS_CONF_2013_065_T2ttobs", _value1 );
  SetOutput( "ATLAS_CONF_2013_065_T2ttexp", _value1 );
  SetOutput( "ATLAS_CONF_2013_065_T2ttchi2", _value0 );
  SetOutput( "CMS_SUS_12_024_T1bbbbtheo", _value1 );
  SetOutput( "CMS_SUS_12_024_T1bbbbobs", _value1 );
  SetOutput( "CMS_SUS_12_024_T1bbbbexp", _value1 );
  SetOutput( "CMS_SUS_12_024_T1bbbbchi2", _value0 );
  SetOutput( "CMS_SUS_12_024_T5tttttheo", _value1 );
  SetOutput( "CMS_SUS_12_024_T5ttttobs", _value1 );
  SetOutput( "CMS_SUS_12_024_T5ttttexp", _value1 );
  SetOutput( "CMS_SUS_12_024_T5ttttchi2", _value0 );
  SetOutput( "CMS_SUS_12_028_T1theo", _value1 );
  SetOutput( "CMS_SUS_12_028_T1obs", _value1 );
  SetOutput( "CMS_SUS_12_028_T1exp", _value1 );
  SetOutput( "CMS_SUS_12_028_T1chi2", _value0 );
  SetOutput( "CMS_SUS_12_028_T1bbbbtheo", _value1 );
  SetOutput( "CMS_SUS_12_028_T1bbbbobs", _value1 );
  SetOutput( "CMS_SUS_12_028_T1bbbbexp", _value1 );
  SetOutput( "CMS_SUS_12_028_T1bbbbchi2", _value0 );
  SetOutput( "CMS_SUS_13_006_TChiWZtheo", _value1 );
  SetOutput( "CMS_SUS_13_006_TChiWZobs", _value1 );
  SetOutput( "CMS_SUS_13_006_TChiWZexp", _value1 );
  SetOutput( "CMS_SUS_13_006_TChiWZchi2", _value0 );
  SetOutput( "CMS_SUS_13_006_TSlepSleptheo", _value1 );
  SetOutput( "CMS_SUS_13_006_TSlepSlepobs", _value1 );
  SetOutput( "CMS_SUS_13_006_TSlepSlepexp", _value1 );
  SetOutput( "CMS_SUS_13_006_TSlepSlepchi2", _value0 );
  SetOutput( "CMS_SUS_13_006_TChiChipmSlepLtheo", _value1 );
  SetOutput( "CMS_SUS_13_006_TChiChipmSlepLobs", _value1 );
  SetOutput( "CMS_SUS_13_006_TChiChipmSlepLexp", _value1 );
  SetOutput( "CMS_SUS_13_006_TChiChipmSlepLchi2", _value0 );
  SetOutput( "CMS_SUS_13_006_TChiChipmSlepStautheo", _value1 );
  SetOutput( "CMS_SUS_13_006_TChiChipmSlepStauobs", _value1 );
  SetOutput( "CMS_SUS_13_006_TChiChipmSlepStauexp", _value1 );
  SetOutput( "CMS_SUS_13_006_TChiChipmSlepStauchi2", _value0 );
  SetOutput( "CMS_SUS_13_011_T6bbWWtheo", _value1 );
  SetOutput( "CMS_SUS_13_011_T6bbWWobs", _value1 );
  SetOutput( "CMS_SUS_13_011_T6bbWWexp", _value1 );
  SetOutput( "CMS_SUS_13_011_T6bbWWchi2", _value0 );
  SetOutput( "CMS_SUS_13_012_T1theo", _value1 );
  SetOutput( "CMS_SUS_13_012_T1obs", _value1 );
  SetOutput( "CMS_SUS_13_012_T1exp", _value1 );
  SetOutput( "CMS_SUS_13_012_T1chi2", _value0 );
  SetOutput( "CMS_PAS_SUS_13_008_T6ttWWtheo", _value1 );
  SetOutput( "CMS_PAS_SUS_13_008_T6ttWWobs", _value1 );
  SetOutput( "CMS_PAS_SUS_13_008_T6ttWWexp", _value1 );
  SetOutput( "CMS_PAS_SUS_13_008_T6ttWWchi2", _value0 );
  SetOutput( "CMS_PAS_SUS_13_018_T2bbtheo", _value1 );
  SetOutput( "CMS_PAS_SUS_13_018_T2bbobs", _value1 );
  SetOutput( "CMS_PAS_SUS_13_018_T2bbexp", _value1 );
  SetOutput( "CMS_PAS_SUS_13_018_T2bbchi2", _value0 );
  SetOutput( "CMS_PAS_SUS_13_019_T1theo", _value1 );
  SetOutput( "CMS_PAS_SUS_13_019_T1obs", _value1 );
  SetOutput( "CMS_PAS_SUS_13_019_T1exp", _value1 );
  SetOutput( "CMS_PAS_SUS_13_019_T1chi2", _value0 );
  SetOutput( "CMS_PAS_SUS_13_019_T1bbbbtheo", _value1 );
  SetOutput( "CMS_PAS_SUS_13_019_T1bbbbobs", _value1 );
  SetOutput( "CMS_PAS_SUS_13_019_T1bbbbexp", _value1 );
  SetOutput( "CMS_PAS_SUS_13_019_T1bbbbchi2", _value0 );
  SetOutput( "CMS_PAS_SUS_13_019_T2bbtheo", _value1 );
  SetOutput( "CMS_PAS_SUS_13_019_T2bbobs", _value1 );
  SetOutput( "CMS_PAS_SUS_13_019_T2bbexp", _value1 );
  SetOutput( "CMS_PAS_SUS_13_019_T2bbchi2", _value0 );
  SetOutput( "CMS_PAS_SUS_14_011_T1bbbbtheo", _value1 );
  SetOutput( "CMS_PAS_SUS_14_011_T1bbbbobs", _value1 );
  SetOutput( "CMS_PAS_SUS_14_011_T1bbbbexp", _value1 );
  SetOutput( "CMS_PAS_SUS_14_011_T1bbbbchi2", _value0 );
  SetOutput( "CMS_SUS_12_024_T1tttttheo", _value1 );
  SetOutput( "CMS_SUS_12_024_T1ttttobs", _value1 );
  SetOutput( "CMS_SUS_12_024_T1ttttexp", _value1 );
  SetOutput( "CMS_SUS_12_024_T1ttttchi2", _value0 );
  SetOutput( "CMS_SUS_12_028_T1tttttheo", _value1 );
  SetOutput( "CMS_SUS_12_028_T1ttttobs", _value1 );
  SetOutput( "CMS_SUS_12_028_T1ttttexp", _value1 );
  SetOutput( "CMS_SUS_12_028_T1ttttchi2", _value0 );
  SetOutput( "CMS_SUS_12_028_T2theo", _value1 );
  SetOutput( "CMS_SUS_12_028_T2obs", _value1 );
  SetOutput( "CMS_SUS_12_028_T2exp", _value1 );
  SetOutput( "CMS_SUS_12_028_T2chi2", _value0 );
  SetOutput( "CMS_SUS_12_028_T2bbtheo", _value1 );
  SetOutput( "CMS_SUS_12_028_T2bbobs", _value1 );
  SetOutput( "CMS_SUS_12_028_T2bbexp", _value1 );
  SetOutput( "CMS_SUS_12_028_T2bbchi2", _value0 );
  SetOutput( "ATLAS_CONF_2012_105_T1tttttheo", _value1 );
  SetOutput( "ATLAS_CONF_2012_105_T1ttttobs", _value1 );
  SetOutput( "ATLAS_CONF_2012_105_T1ttttexp", _value1 );
  SetOutput( "ATLAS_CONF_2012_105_T1ttttchi2", _value0 );
  SetOutput( "ATLAS_CONF_2013_007_T1tttttheo", _value1 );
  SetOutput( "ATLAS_CONF_2013_007_T1ttttobs", _value1 );
  SetOutput( "ATLAS_CONF_2013_007_T1ttttexp", _value1 );
  SetOutput( "ATLAS_CONF_2013_007_T1ttttchi2", _value0 );
  SetOutput( "ATLAS_SUSY_2013_12_TChiWZtheo", _value1 );
  SetOutput( "ATLAS_SUSY_2013_12_TChiWZobs", _value1 );
  SetOutput( "ATLAS_SUSY_2013_12_TChiWZexp", _value1 );
  SetOutput( "ATLAS_SUSY_2013_12_TChiWZchi2", _value0 );
  SetOutput( "ATLAS_SUSY_2013_11_TChiWZtheo", _value1 );
  SetOutput( "ATLAS_SUSY_2013_11_TChiWZobs", _value1 );
  SetOutput( "ATLAS_SUSY_2013_11_TChiWZexp", _value1 );
  SetOutput( "ATLAS_SUSY_2013_11_TChiWZchi2", _value0 );
  SetOutput( "ATLAS_SUSY_2013_15_T2tttheo", _value1 );
  SetOutput( "ATLAS_SUSY_2013_15_T2ttobs", _value1 );
  SetOutput( "ATLAS_SUSY_2013_15_T2ttexp", _value1 );
  SetOutput( "ATLAS_SUSY_2013_15_T2ttchi2", _value0 );
  SetOutput( "CMS_SUS_13_012_T1tttttheo", _value1 );
  SetOutput( "CMS_SUS_13_012_T1ttttobs", _value1 );
  SetOutput( "CMS_SUS_13_012_T1ttttexp", _value1 );
  SetOutput( "CMS_SUS_13_012_T1ttttchi2", _value0 );
  SetOutput( "CMS_SUS_13_012_T2theo", _value1 );
  SetOutput( "CMS_SUS_13_012_T2obs", _value1 );
  SetOutput( "CMS_SUS_13_012_T2exp", _value1 );
  SetOutput( "CMS_SUS_13_012_T2chi2", _value0 );
  SetOutput( "CMS_SUS_13_013_T1tttttheo", _value1 );
  SetOutput( "CMS_SUS_13_013_T1ttttobs", _value1 );
  SetOutput( "CMS_SUS_13_013_T1ttttexp", _value1 );
  SetOutput( "CMS_SUS_13_013_T1ttttchi2", _value0 );
  SetOutput( "ATLAS_SUSY_2013_19_T6bbWWtheo", _value1 );
  SetOutput( "ATLAS_SUSY_2013_19_T6bbWWobs", _value1 );
  SetOutput( "ATLAS_SUSY_2013_19_T6bbWWexp", _value1 ); 
  SetOutput( "ATLAS_SUSY_2013_19_T6bbWWchi2", _value0 );
  SetOutput( "CMS_SUS_13_011_T2tttheo", _value1 );
  SetOutput( "CMS_SUS_13_011_T2ttobs", _value1 );
  SetOutput( "CMS_SUS_13_011_T2ttexp", _value1 );
  SetOutput( "CMS_SUS_13_011_T2ttchi2", _value0 );
  SetOutput( "ATLAS_CONF_2013_024_T2tttheo", _value1 );
  SetOutput( "ATLAS_CONF_2013_024_T2ttobs", _value1 );
  SetOutput( "ATLAS_CONF_2013_024_T2ttexp", _value1 );
  SetOutput( "ATLAS_CONF_2013_024_T2ttchi2", _value0 );
  SetOutput( "CMS_PAS_SUS_13_019_T1tttttheo", _value1 );
  SetOutput( "CMS_PAS_SUS_13_019_T1ttttobs", _value1 );
  SetOutput( "CMS_PAS_SUS_13_019_T1ttttexp", _value1 );
  SetOutput( "CMS_PAS_SUS_13_019_T1ttttchi2", _value0 );
  SetOutput( "CMS_PAS_SUS_13_019_T2tttheo", _value1 );
  SetOutput( "CMS_PAS_SUS_13_019_T2ttobs", _value1 );
  SetOutput( "CMS_PAS_SUS_13_019_T2ttexp", _value1 );
  SetOutput( "CMS_PAS_SUS_13_019_T2ttchi2", _value0 ); 
  SetOutput( "CMS_PAS_SUS_13_019_T2theo", _value1 );
  SetOutput( "CMS_PAS_SUS_13_019_T2obs", _value1 );
  SetOutput( "CMS_PAS_SUS_13_019_T2exp", _value1 );
  SetOutput( "CMS_PAS_SUS_13_019_T2chi2", _value0 );
  SetOutput( "CMS_SUS_13_002_T1tttttheo", _value1 );
  SetOutput( "CMS_SUS_13_002_T1ttttobs", _value1 );
  SetOutput( "CMS_SUS_13_002_T1ttttexp", _value1 );
  SetOutput( "CMS_SUS_13_002_T1ttttchi2", _value0 );
  SetOutput( "ATLAS_SUSY_2013_04_T1tttttheo", _value1 );
  SetOutput( "ATLAS_SUSY_2013_04_T1ttttobs", _value1 );
  SetOutput( "ATLAS_SUSY_2013_04_T1ttttexp", _value1 );
  SetOutput( "ATLAS_SUSY_2013_04_T1ttttchi2", _value0 );
  SetOutput( "ATLAS_SUSY_2013_02_T2theo", _value1 );
  SetOutput( "ATLAS_SUSY_2013_02_T2obs", _value1 );
  SetOutput( "ATLAS_SUSY_2013_02_T2exp", _value1 );
  SetOutput( "ATLAS_SUSY_2013_02_T2chi2", _value0 );
  SetOutput( "CMS_PAS_SUS_13_008_T1tttttheo", _value1 );
  SetOutput( "CMS_PAS_SUS_13_008_T1ttttobs", _value1 );
  SetOutput( "CMS_PAS_SUS_13_008_T1ttttexp", _value1 );
  SetOutput( "CMS_PAS_SUS_13_008_T1ttttchi2", _value0 );
  SetOutput( "CMS_SUS_13_007_T1tttttheo", _value1 );
  SetOutput( "CMS_SUS_13_007_T1ttttobs", _value1 );
  SetOutput( "CMS_SUS_13_007_T1ttttexp", _value1 );
  SetOutput( "CMS_SUS_13_007_T1ttttchi2", _value0 );
  SetOutput( "CMS_PAS_SUS_14_011_T2tttheo", _value1 );
  SetOutput( "CMS_PAS_SUS_14_011_T2ttobs", _value1 );
  SetOutput( "CMS_PAS_SUS_14_011_T2ttexp", _value1 );
  SetOutput( "CMS_PAS_SUS_14_011_T2ttchi2", _value0 );
  SetOutput( "CMS_PAS_SUS_14_011_T1tttttheo", _value1 );
  SetOutput( "CMS_PAS_SUS_14_011_T1ttttobs", _value1 );
  SetOutput( "CMS_PAS_SUS_14_011_T1ttttexp", _value1 );
  SetOutput( "CMS_PAS_SUS_14_011_T1ttttchi2", _value0 );
  SetOutput( "CMS_PAS_SUS_13_016_T1tttttheo", _value1 );
  SetOutput( "CMS_PAS_SUS_13_016_T1ttttobs", _value1 );
  SetOutput( "CMS_PAS_SUS_13_016_T1ttttexp", _value1 );
  SetOutput( "CMS_PAS_SUS_13_016_T1ttttchi2", _value0 );
  SetOutput( "ATLAS_CONF_2013_061_T1tttttheo", _value1 );
  SetOutput( "ATLAS_CONF_2013_061_T1ttttobs", _value1 );
  SetOutput( "ATLAS_CONF_2013_061_T1ttttexp", _value1 );
  SetOutput( "ATLAS_CONF_2013_061_T1ttttchi2", _value0 );
   
  std::fstream myfile;
  std::string line;

  myfile.open("/lustre/user/range/fittino/bin/summary.txt");
  
  while( getline (myfile, line) ){

      typedef std::vector< std::string > split_vector_type;

      split_vector_type SplitVecTable;
      split( SplitVecTable, line, boost::is_any_of(" \t"), boost::token_compress_on);
      
      if( SplitVecTable.size() > 7 ) {
      if( SplitVecTable[2] == "[pb]") {
	
	std::string analyse;
	
	std::string analysevec1 = SplitVecTable[0];
        split_vector_type SplitVecAnalyse1;
        split( SplitVecAnalyse1, analysevec1, boost::is_any_of(":"), boost::token_compress_on);
	  
        std::string analyse0 = SplitVecAnalyse1[1];
        
	std::string analysevec2 = SplitVecAnalyse1[0];
	split_vector_type SplitVecAnalyse2;
	split( SplitVecAnalyse2, analysevec2, boost::is_any_of("-"), boost::token_compress_on);
	
	if( SplitVecAnalyse2.size() > 3 ){
	  if( SplitVecAnalyse2.size() < 5 ){
	  
	      std::string analyse1 = SplitVecAnalyse2[0];
	      std::string analyse2 = SplitVecAnalyse2[1];
	      std::string analyse3 = SplitVecAnalyse2[2];
	      std::string analyse4 = SplitVecAnalyse2[3];
	      
	      analyse = analyse1 + "_" + analyse2 + "_" + analyse3 + "_" + analyse4 + "_" + analyse0; 
	      	      
	      name1 = analyse + "theo";
	      name2 = analyse + "obs";
	      name3 = analyse + "exp";
	      name4 = analyse + "chi2";
	      
	      std::string Theo = SplitVecTable[1];
	      _theo = boost::lexical_cast<double>(Theo);
	      SetOutput( name1, _theo );


	      std::string Obs = SplitVecTable[3];
	      _obs = boost::lexical_cast<double>(Obs);
	      SetOutput( name2, _obs );


	      std::string Exp = SplitVecTable[5];
	      _exp = boost::lexical_cast<double>(Exp);
	      SetOutput( name3, _exp );


	      std::string Chi2 = SplitVecTable[8];
	      _chi2 = boost::lexical_cast<double>(Chi2);
	      SetOutput( name4, _chi2 );
	      
	      }
	} else continue;

	if( SplitVecAnalyse2.size() > 4 ){
	  
	  std::string analyse1 = SplitVecAnalyse2[0];
	  std::string analyse2 = SplitVecAnalyse2[1];
	  std::string analyse3 = SplitVecAnalyse2[2];
	  std::string analyse4 = SplitVecAnalyse2[3];
	  std::string analyse5 = SplitVecAnalyse2[4];
	  
	  analyse = analyse1 + "_" + analyse2 + "_" + analyse3 + "_" + analyse4 + "_" + analyse5 + "_" + analyse0;
	  
            name1 = analyse + "theo";
            name2 = analyse + "obs";
            name3 = analyse + "exp";
            name4 = analyse + "chi2";
            
          std::string Theo = SplitVecTable[1];
          _theo = boost::lexical_cast<double>(Theo);
          SetOutput( name1, _theo );
	    

          std::string Obs = SplitVecTable[3];
          _obs = boost::lexical_cast<double>(Obs);
          SetOutput( name2, _obs );
	    

          std::string Exp = SplitVecTable[5];
          _exp = boost::lexical_cast<double>(Exp);
          SetOutput( name3, _exp );
	    

          std::string Chi2 = SplitVecTable[8];
          _chi2 = boost::lexical_cast<double>(Chi2);    
          SetOutput( name4, _chi2 );
	
	} else continue;
       }
      } else continue;

      split_vector_type SplitVec;
      split( SplitVec, line, boost::is_any_of(" "), boost::token_compress_on);
          
      if( SplitVec.size() > 5 ) {
      if( SplitVec[3] == "value" ){

       R = SplitVec[6];
       _r = boost::lexical_cast<double>(R);
	   
	 std::cout << "The highest r value is = " << _r << std::endl;

	  }
      } else continue;
      }

  myfile.close();

  myfile.open("/lustre/user/range/fittino/bin/summary.txt");

  while( getline (myfile, line) ){

    typedef std::vector< std::string > split_vector_type;
    split_vector_type SplitVecTable;
    split( SplitVecTable, line, boost::is_any_of(" \t"), boost::token_compress_on);       
     
    double r1_SModelS_compare;
    double r1_rounded_compare;

    double r2_SModelS_compare;
    double r2_compare;

    split_vector_type SplitVecR;
    split( SplitVecR, R, boost::is_any_of("E"), boost::token_compress_on);

    if( SplitVecR.size() > 1) {

      std::string R1_SModelS = SplitVecR[0];
      std::string R2_SModelS = SplitVecR[1];
      
      r1_SModelS_compare = boost::lexical_cast<double>(R1_SModelS);
      r2_SModelS_compare = boost::lexical_cast<double>(R2_SModelS);
     
    }

    	if( SplitVecTable.size() > 7 ) {

	  std::string number = SplitVecTable[7];
	  	  
	  split_vector_type SplitVecNumber;
	  split( SplitVecNumber, number, boost::is_any_of("E"), boost::token_compress_on);
	  
	  
	  if( SplitVecNumber.size() > 1 ) {

	    std::string R1 = SplitVecNumber[0];
	    std::string R2 = SplitVecNumber[1];
	    
	    double r1 = boost::lexical_cast<double>(R1); 
	    r2_compare = boost::lexical_cast<double>(R2);
	   	    
	    int r12;
	    int r121;
	    	      
	    r12 = r1 * 100.0;
	    r121 = r1 * 1000.0;
	    
	    int r1211 = r121 / 10.0;
	    int r1221 = (r121 + 5) / 10.0;
	    int r13;
	        
	    if ( r1221 > r1211 ) { 
	    
	      r13 = r12 + 1.0;
	    
	    }
	    
	    else {
	      
	      r13 = r12;
	    
	    }

	    r1_rounded_compare = r13 / 100.0;
	    	    	    	    	  
	  }
	  
	  if( r2_compare == r2_SModelS_compare ) {
	      if( r1_rounded_compare == r1_SModelS_compare ) {
	    
	    std::string string1 = SplitVecTable[1];
	    std::string string2 = SplitVecTable[2];
	    string = string1 + ":" + string2;
	      
	      }
	  }
	  	      
	}
  }

 myfile.close();

 myfile.open("/lustre/user/range/fittino/bin/summary.txt");
 while( getline (myfile, line) ){

   typedef std::vector< std::string > split_vector_type;
   split_vector_type SplitVecTable;
   split( SplitVecTable, line, boost::is_any_of(" \t"), boost::token_compress_on);
   
   if( SplitVecTable.size() > 7 ) {

   std::string analyse = SplitVecTable[0];
   
   if( analyse == string ) {
     
     std::string Chi2 = SplitVecTable[8];
     _Chi2 = boost::lexical_cast<double>(Chi2);
     std::cout << "Chi2: " << _Chi2 << std::endl;

       }
   }
 }

 myfile.close();


}

void Fittino::SModelSCalculator::Initialize() {

}
