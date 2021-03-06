#include <array>
#include <fstream>
#include <iomanip>
#include <iostream>
#include <numeric>
#include <sstream>
#include <vector>

using namespace std;

#include "../vm/types.hpp"
#include "../vm/opcodes.hpp"
#include "../vm/loader.hpp"

#include "disasm.cpp"

using namespace paiv;


int main(int argc, char* argv[])
{
  if (argc < 2)
  {
    cout << "usage: ida <image>" << endl;
    return 0;
  }

  ImageLoader loader;
  auto image = loader.read(argv[1]);

  Disassembler disasm;
  disasm.disassemble(image, cout);

  return 0;
}
