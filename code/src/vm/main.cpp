#include <array>
#include <fstream>
#include <iostream>
#include <vector>

#include "types.hpp"
#include "opcodes.hpp"
#include "vm.cpp"

using namespace std;
using namespace paiv;

int main(int argc, char* argv[])
{
  if (argc < 2)
  {
    cout << "usage: vm <image>" << endl;
    return 0;
  }

  ImageLoader loader;
  auto image = loader.read(argv[1]);

  SynacorVM vm;
  vm.exec(image);

  return 0;
}
