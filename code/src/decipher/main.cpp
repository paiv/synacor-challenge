#include <fstream>
#include <iomanip>
#include <iostream>
#include <map>
#include <sstream>
#include <vector>

using namespace std;

#include "../vm/types.hpp"
#include "../vm/loader.hpp"
#include "../vm/opcodes.hpp"
#include "../ida/disasm.cpp"

using namespace paiv;


namespace paiv
{
  typedef vector<u16> chunk;


  static ostream&
  dumpSecureStrings(ostream& so, const chunk& image)
  {
    Disassembler dis;
    auto ops = dis.decode(image);

    for (auto it = begin(ops); it != end(ops); it++)
    {
      auto& op = *it;
      if (op.opcode == Op::CALL && op.a == 0x5b2)
      {
        auto& op1 = *(it - 3);
        auto& op2 = *(it - 2);
        auto& op3 = *(it - 1);

        if (op2.opcode == Op::SET && op2.a == 0x8001 && op2.b == 0x5fb
          && op1.opcode == Op::SET && op1.a == 0x8000
          && op3.opcode == Op::ADD && op3.a == 0x8002)
        {
          so << setfill('0') << hex << setw(4) << op.offset;
          so << " " << setw(4) << op1.b << ": ";

          u16 size = image[op1.b];
          auto p = begin(image) + op1.b + 1;
          chunk buf(p, p + size);
          u16 key = op3.b + op3.c;

          string s(size, '@');
          transform(begin(buf), end(buf), &s[0], [key](u16 x){ return (char)(x ^ key); });
          so << s << endl;
        }
        else
        {
          so << setfill('0') << hex << setw(4) << op.offset << ": ???" << endl;
        }

      }
    }

    return so;
  }


  static ostream&
  pipeOut(ostream& so, const chunk& image)
  {
    Disassembler dis;
    auto ops = dis.decode(image);

    for (auto& op : ops)
    {
      if (op.opcode == Op::OUT)
        so << (u8)op.a;
    }
    return so;
  }
}


int main(int argc, char* argv[])
{
  if (argc < 2)
  {
    cout << "usage: decipher <dumpfile>" << endl;
    return 0;
  }

  ImageLoader loader;
  auto image = loader.read(argv[1]);

  dumpSecureStrings(cout, image);

#if 0
  ofstream f(argv[1], ios::binary);
  pipeOut(f, image);
#endif

  return 0;
}
