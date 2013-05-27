#ifndef FLOAT_STORAGE_H
#define FLOAT_STORAGE_H

#include <map>
#include <TTree.h>

class FloatStorage{

 public:

  FloatStorage( TTree* tree );
  ~FloatStorage();

  void           Add( std::string name, float value = 0 );
  void           Connect( TTree* tree );
  bool           Contains(std::string name);
  const float&   Get( std::string name ) const;
  void           Set( std::string name, float value );
  void           Set( std::string name, std::string value );

 private:
  std::map<std::string, float>  _map;
  TTree*                        _tree; 

};


#endif

