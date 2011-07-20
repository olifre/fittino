#include "src/RecoTree.h"

using namespace std;


int main()
{
  RecoTree t;

  cout << " >>> Region 2jets..."<< endl;
  float n2 = t.Loop( "2jets" );
  cout << " >>> Region 3jets..."<< endl;
  float n3 = t.Loop( "3jets" );
  cout << " >>> Region 4jets..."<< endl;
  float n4 = t.Loop( "4jets" );
    
  cout << " >>> Number of events..."<< endl;
  cout << "Region 2jets: " << n2 << endl;
  cout << "Region 3jets: " << n3 << endl;
  cout << "Region 4jets: " << n4 << endl;

  t.writeResults( n2, n3, n4 );

  return 0;  
}
  
