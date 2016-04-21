#include <array>
#include <fstream>
#include <iomanip>
#include <iostream>
#include <numeric>
#include <sstream>
#include <unistd.h>
#include <vector>
#include <zmq.hpp>

using namespace std;

#include "types.hpp"
#include "opcodes.hpp"
#include "loader.hpp"
#include "vm.cpp"

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
