#include <iostream>
#include <string.h>
#include <vector>

using namespace std;

void main()
{
  vector<string> v{"a", "b", "c"};
  
  for (auto &s : v)
  {
    cout << s << endl;
  }
}