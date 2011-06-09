#include "src/RecoTree.h"

using namespace std;


int main()
{
  RecoTree t;

  cout << " >>> Region A..."<< endl;
  float nA = t.Loop( "A" );
  cout << " >>> Region B..."<< endl;
  float nB = t.Loop( "B" );
  cout << " >>> Region C..."<< endl;
  float nC = t.Loop( "C" );
  cout << " >>> Region D..."<< endl;
  float nD = t.Loop( "D" );

  cout << " >>> Number of events..."<< endl;
  cout << "Region A: " << nA << endl;
  cout << "Region B: " << nB << endl;
  cout << "Region C: " << nC << endl;
  cout << "Region D: " << nD << endl;

  t.writeResults( nA, nB, nC, nD );

  return 0;  
}
  
