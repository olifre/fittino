
#include "Python.h"
#include "FlavioCalculator.h"
#include "CalculatorException.h"
#include "PhysicsModel.h"
#include "SimplePrediction.h"
#include "ModelParameter.h"
#include <iostream>

Fittino::FlavioCalculator::FlavioCalculator( const ModelBase* model, const boost::property_tree::ptree& ptree )
    : CalculatorBase( model, &ptree ) 
{
    
    if ( _name.empty() ) { 

    _tag  = "Flavio";
    _name = "Flavio";

   }

    auto pName = PyUnicode_DecodeFSDefault("flavio.io.flha");
    auto flha = PyImport_Import(pName);

    if ( flha == NULL ) {

    PyErr_Print();
    std::cout<<"Failed to load flavio.io.flha"<<std::endl;

}

    _readWilson = PyObject_GetAttrString(flha, "read_wilson");

    if ( !_readWilson || !PyCallable_Check(_readWilson)) {


        if (PyErr_Occurred())
            PyErr_Print();
        std::cout<<"Falied to load read_wilson"<<std::endl;


    }

    auto pName2 = PyUnicode_DecodeFSDefault("flavio");
    auto flavio = PyImport_Import(pName2);
    if ( flavio == NULL ) {

        PyErr_Print();
        std::cout<<"Falied to load flavio"<<std::endl;

    }

     _npPrediction = PyObject_GetAttrString(flavio, "np_prediction");

    if ( !_npPrediction || !PyCallable_Check(_npPrediction)) {


        if (PyErr_Occurred())
            PyErr_Print();
        std::cout<<"Failed to load np_prediction"<<std::endl;


    }

    _smPrediction = PyObject_GetAttrString(flavio, "sm_prediction");

    if ( !_smPrediction || !PyCallable_Check(_smPrediction)) {


        if (PyErr_Occurred())
            PyErr_Print();
        std::cout<<"Failed to load sm_prediction"<<std::endl;


    }

    AddBinnedPrediction( "R_K_LHCb", "<Rmue>(B+->Kll)", 1.0, 6.0 );
   // AddBinnedPrediction( "BR_B_K_mu_mu_LHCb", "<BR>(B+->Kmumu)", 1.0, 6.0 );
  //  AddBinnedPrediction( "BR_B_K_e_e_LHCb", "<BR>(B+->Kee)", 1.0, 6.0 );

    AddBinnedPrediction( "R_Kstar0_LHCb_lowq2", "<Rmue>(B0->K*ll)", 0.045, 1.1 );
   // AddBinnedPrediction( "BR_B0_Kstar0_mu_mu_LHCb_lowq2", "<BR>(B0->K*mumu)", 0.045, 1.1 );
   // AddBinnedPrediction( "BR_B0_Kstar0_e_e_LHCb_lowq2", "<BR>(B0->K*ee)", 0.045, 1.1 );

    AddBinnedPrediction( "R_Kstar0_LHCb_centralq2", "<Rmue>(B0->K*ll)", 1.1, 6.0 );
   // AddBinnedPrediction( "BR_B0_Kstar0_mu_mu_LHCb_centralq2", "<BR>(B0->K*mumu)", 1.1, 6.0 );
   // AddBinnedPrediction( "BR_B0_Kstar0_e_e_LHCb_centralq2", "<BR>(B0->K*ee)", 1.1, 6.0 );

    AddInclusivePrediction( "R_D", "Rtaul(B->Dlnu)" );
    AddInclusivePrediction( "R_Dstar", "Rtaul(B->D*lnu)" );

    //AddInclusivePrediction( "R_K", "Rmue(B+->Kll)" );
    //AddInclusivePrediction( "R_Kstar0", "Rmue(B0->K*ll)" );

}

Fittino::FlavioCalculator::~FlavioCalculator() {



}

void Fittino::FlavioCalculator::CalculatePredictions() {

    ReadSLHAFile();

    for( unsigned int i = 0 ; i < _predictions.size(); i++ ) {

        PyTuple_SetItem( _npargs.at(i), 1, _wc );

        auto npValue = PyObject_CallObject(_npPrediction, _npargs.at(i)  );
        SetOutput( _predictions.at(i), PyFloat_AsDouble( npValue ) );

        auto smValue = PyObject_CallObject(_smPrediction, _smargs.at(i) );
        SetOutput( "SM_" + _predictions.at(i), PyFloat_AsDouble( smValue ) );

        SetOutput( "NormSM_" + _predictions.at(i), PyFloat_AsDouble( npValue )  / PyFloat_AsDouble( smValue )   );

        Py_DECREF(npValue);

    }

}

void Fittino::FlavioCalculator::ReadSLHAFile() {

    auto arg = PyUnicode_DecodeFSDefault("SPheno.spc.MSSMTriLnV");

    auto pArgs = PyTuple_New(1);
    PyTuple_SetItem(pArgs, 0, arg);

    _wc = PyObject_CallObject(_readWilson, pArgs);

    if (_wc == NULL) {

        PyErr_Print();
        std::cout << "Call failed." << std::endl;

    }

    Py_DECREF( pArgs );

}

void Fittino::FlavioCalculator::AddBinnedPrediction( std::string name, std::string id, double q2min, double q2max  ) {

    _predictions.push_back(name);

    auto p_id = PyUnicode_DecodeFSDefault( id.c_str() );
    auto p_q2min = PyFloat_FromDouble( q2min );
    auto p_q2max = PyFloat_FromDouble( q2max );

    PyObject* npargs = PyTuple_New(4);
    PyTuple_SetItem(npargs, 0, p_id);
    PyTuple_SetItem(npargs, 2, p_q2min);
    PyTuple_SetItem(npargs, 3, p_q2max);
    _npargs.push_back(npargs);

    PyObject* smargs = PyTuple_New(3);
    PyTuple_SetItem(smargs, 0, p_id);
    PyTuple_SetItem(smargs, 1, p_q2min);
    PyTuple_SetItem(smargs, 2, p_q2max);
    _smargs.push_back(smargs);

    AddOutput( name );
    AddOutput( "SM_" + name );
    AddOutput( "NormSM_" + name );


}

void Fittino::FlavioCalculator::AddInclusivePrediction( std::string name, std::string id) {

    _predictions.push_back(name);

    auto p_id = PyUnicode_DecodeFSDefault( id.c_str() );

    PyObject* npargs = PyTuple_New(2);
    PyTuple_SetItem(npargs, 0, p_id);
    _npargs.push_back(npargs);

    PyObject* smargs = PyTuple_New(1);
    PyTuple_SetItem(smargs, 0, p_id);
    _smargs.push_back(smargs);

    AddOutput( name );
    AddOutput( "SM_" + name );
    AddOutput( "NormSM_" + name );


}