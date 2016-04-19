#include <array>
#include <iomanip>
#include <iostream>
#include <fstream>
#include <sstream>
#include <vector>

#include "../vm/types.hpp"
#include "../vm/opcodes.hpp"
#include "../vm/vm.cpp"
#include "disasm.cpp"

using namespace std;
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
  // vector<u16> image = { Op::JMP, 2, 'a', 'b', 'c', 0x6564, 2000, 2109, 'x', 'z', Op::OUT, 'X', Op::OUT, '\n', Op::RET };

  Disassembler disasm;
  disasm.disassemble(image, cout);

  return 0;
}
