#include "src/RecoTree.h"

using namespace std;


int main()
{
  RecoTree t;

  cout << " >>> Region A..."<< endl;
  int nA = t.Loop( "A" );
  cout << " >>> Region B..."<< endl;
  int nB = t.Loop( "B" );
  cout << " >>> Region C..."<< endl;
  int nC = t.Loop( "C" );
  cout << " >>> Region D..."<< endl;
  int nD = t.Loop( "D" );

  cout << " >>> Number of events..."<< endl;
  cout << "Region A: " << nA << endl;
  cout << "Region B: " << nB << endl;
  cout << "Region C: " << nC << endl;
  cout << "Region D: " << nD << endl;

  t.writeResults( nA, nB, nC, nD );

  return 0;  
}
  
