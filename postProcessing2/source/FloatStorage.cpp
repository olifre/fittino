#include "FloatStorage.h"
#include "TLeafD.h"
#include <limits>
#include <iostream>
#include <sstream>
#include <utility>
#include <stdexcept>

FloatStorage::FloatStorage( TTree* tree ) {

  _tree = tree;

}

FloatStorage::~FloatStorage() {

}

void FloatStorage::Add(std::string name, float value) {

  std::pair<std::map<std::string, float>::iterator, bool> ret;  

  std::pair<std::string, float> pair =  std::make_pair( name, value );
  
  ret = _map.insert( pair );

  if ( ret.second == false ) {

    throw std::runtime_error( "Adding already existing key."  );
   
  }
  else if ( _tree ) {

    TBranch* br = (TBranch*) _tree->GetListOfBranches()->FindObject( name.c_str() );
    
    if ( !br ) {

      _tree->Branch( name.c_str(), &_map[name] );    

    }

  }
  
}

void FloatStorage::Connect( TTree* tree ){

  unsigned int nLeaves = tree->GetListOfLeaves()->GetEntries();  

  for (unsigned int iLeaf = 0; iLeaf < nLeaves; iLeaf++ ) {

    TLeafD* leaf = (TLeafD*) tree->GetListOfLeaves()->At(iLeaf);
    TString leafName=leaf->GetName();
    TString newLeafName = leafName;
    newLeafName.ReplaceAll("_nofit", "");
    std::string key= std::string(newLeafName.Data());

    if ( !Contains(key) ){

      Add(key, 0);

    }

    tree->SetBranchAddress( leafName.Data(), &_map[key] ) ;
    
  }

}

bool FloatStorage::Contains( std::string name ) {

  return _map.count(name);  

}

const float& FloatStorage::Get( std::string name ) const {

  try {

    return _map.at( name );

  }
  catch ( std::out_of_range ) {
    
    std::cout<<name<<" not in tree."<<std::endl;
    throw;

  }

}

void FloatStorage::Set( std::string name, float value ) {

  try {

    _map.at(name)=value;

  }
  catch ( std::out_of_range ) {
    
    std::cout<<name<<" not in tree."<<std::endl;
    throw;

  }

}

void FloatStorage::Set( std::string name, std::string value ) {

  float floatBuffer=std::numeric_limits<double>::quiet_NaN();
  std::stringstream sstr;
  sstr<<value;
  sstr>>floatBuffer;

  try {

    _map.at(name)=floatBuffer;
    
  }
  catch ( std::out_of_range ) {
    
    std::cout<<name<<" not in tree."<<std::endl;
    throw;

  }

}

