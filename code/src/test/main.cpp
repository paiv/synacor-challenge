#include <array>
#include <cassert>
#include <iostream>
#include <fstream>
#include <vector>

#include "../main/types.hpp"
#include "../main/opcodes.hpp"
#include "../main/vm.cpp"

using namespace std;
using namespace paiv;

#define RUN_TEST(name) name()


class CheckedSynacorVM : public SynacorVM
{
public:
  u16 mem(u16 index) { return SynacorVM::mem[index]; }
  u16 ip() { return SynacorVM::ip; }
  u16 sp() { return SynacorVM::sp; }
};


void
vm_loader()
{
  vector<u16> image = { Op::NOOP, Op::NOOP, Op::HALT };
  CheckedSynacorVM vm;

  vm.load(image);

  assert(vm.mem(0) == Op::NOOP);
  assert(vm.mem(1) == Op::NOOP);
  assert(vm.mem(2) == Op::HALT);
  assert(vm.ip() == 0);
  assert(vm.sp() == 0);
}


void
vm_halt()
{
  vector<u16> image = { Op::HALT };
  CheckedSynacorVM vm;

  vm.exec(image);

  assert(vm.ip() == 0);
}

void
vm_noop()
{
  vector<u16> image = { Op::NOOP, Op::HALT };
  CheckedSynacorVM vm;

  vm.exec(image);

  assert(vm.ip() == 1);
}

void
vm_out()
{
  vector<u16> image = { Op::OUT, 'X', Op::OUT, 'x', Op::OUT, '\n', Op::HALT };
  CheckedSynacorVM vm;

  vm.exec(image);
}


int main()
{
  RUN_TEST(vm_loader);
  RUN_TEST(vm_halt);
  RUN_TEST(vm_noop);
  // RUN_TEST(vm_out);
  return 1;
}
