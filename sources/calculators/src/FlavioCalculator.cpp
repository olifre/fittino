
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
    
    
#ifdef WCxf
    
    _wilsonCoefficients = PyObject_GetAttrString(flavio, "WilsonCoefficients");
    
    if ( !_wilsonCoefficients || !PyCallable_Check(_wilsonCoefficients ) ) {
        
        
        if (PyErr_Occurred())
        PyErr_Print();
        std::cout<<"Failed to load WilsonCoefficients class from flavio"<<std::endl;
        
        
    }
    
    auto wcxf_name = PyUnicode_DecodeFSDefault( "wcxf" );
    auto wcxf_module = PyImport_Import( wcxf_name );
    
    if ( wcxf_module == NULL ) {
        
        PyErr_Print();
        std::cout<<"Falied to load wcxf"<<std::endl;
        
    }
    
    auto wcxf_wc = PyObject_GetAttrString (wcxf_module, "WC" );

    if ( wcxf_wc == NULL ) {
        
        PyErr_Print();
        std::cout<<"Falied to load wcxf.WC"<<std::endl;
        
    }
    
    _loadWilson = PyObject_GetAttrString (wcxf_wc, "load" );

    if ( _loadWilson == NULL ) {
        
        PyErr_Print();
        std::cout<<"Falied to load wcxf.WC.load"<<std::endl;
        
    }
    
    
    _io_module = PyImport_ImportModule("io");
    
    if ( _io_module == NULL ) {
        
        PyErr_Print();
        std::cout<<"Falied to import io module."<<std::endl;
        
    }
    

#endif

    AddBinnedPrediction( "R_K_LHCb", "<Rmue>(B+->Kll)", 1.0, 6.0 );
    AddBinnedPrediction( "R_Kstar0_LHCb_lowq2", "<Rmue>(B0->K*ll)", 0.045, 1.1 );
    AddBinnedPrediction( "R_Kstar0_LHCb_centralq2", "<Rmue>(B0->K*ll)", 1.1, 6.0 );

    AddInclusivePrediction( "R_D", "Rtaul(B->Dlnu)" );
    AddInclusivePrediction( "R_Dstar", "Rtaul(B->D*lnu)" );
    
    AddInclusivePrediction( "BR_Bp_tau_nu", "BR(B+->taunu)" );
    AddInclusivePrediction( "BR_Bp_K_nu_nu", "BR(B+->Knunu)" );
    AddInclusivePrediction( "BR_Bp_pi_nu_nu", "BR(B+->pinunu)" );
    
    AddInclusivePrediction( "BR_Bs_mu_mu", "BR(Bs->mumu)" );
    AddInclusivePrediction( "BR_B0_mu_mu", "BR(B0->mumu)" );
    
    AddInclusivePrediction( "Delta_Ms", "DeltaM_s" );
    AddInclusivePrediction( "Delta_Md", "DeltaM_d" );
    
    AddInclusivePrediction( "BR_B_Xs_gamma", "BR(B->Xsgamma)" );

}

Fittino::FlavioCalculator::~FlavioCalculator() {



}

void Fittino::FlavioCalculator::CalculatePredictions() {

#ifdef WCxf
    
    ReadWCxfFiles();
    
#else

    ReadSLHAFile();
    
#endif

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

PyObject* Fittino::FlavioCalculator::ReadWCxfFile( std::string file ) {
    
    auto json = PyObject_CallMethod( _io_module, "open", "ss", file.c_str(), "r" );
    
    auto pArgs = PyTuple_New(1);
    PyTuple_SetItem( pArgs, 0, json );
    
    auto wcxf_wc = PyObject_CallObject( _loadWilson, pArgs );
    
    PyObject_CallMethod(  json, "close", NULL );
    
    return wcxf_wc;
    
}

void Fittino::FlavioCalculator::ReadWCxfFiles() {
    
    std::cout<<"Reading WCxf files "<<std::endl;
    
    _wc = PyObject_CallObject( _wilsonCoefficients, NULL );
    auto wcxf1 = ReadWCxfFile( "WC.MSSMTriLnV_1.json" );
    PyObject_CallMethod( _wc, "set_initial_wcxf", "O", wcxf1 );
    
    _wcSM = PyObject_CallObject( _wilsonCoefficients, NULL );
    auto wcxf2 = ReadWCxfFile( "WC.MSSMTriLnV_SM_1.json" );
    PyObject_CallMethod( _wcSM, "set_initial_wcxf", "O", wcxf2 );


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
