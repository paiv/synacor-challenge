
namespace paiv
{

  class Debugger
  {
  public:
    Debugger(zmq::context_t* context, SynacorVM* vm)
      : context(context), vm(vm)
    {
    }

    void disassemble(ostream& so);
    void disassemble(ostream& so, u16 address);
    void showRegisters(ostream& so);
    void dumpMemory(ostream& so, u16 address, u16 size = 16);
    void showStack(ostream& so, u16 size = 8);

    void step();
    void stepOut();
    void resume();
    void breakOn(u16 address);
    void listBreakpoints();
    void clearBreakpoint(u16 address);

  private:
    zmq::context_t* context;
    SynacorVM* vm;

  private:
    void sendCommand(const string& name, u16 arg = 0) const;
  };


  void
  Debugger::disassemble(ostream& so)
  {
    disassemble(so, vm->ip);
  }

  void
  Debugger::disassemble(ostream& so, u16 address)
  {
    auto snapshot = vm->save();
    u16 memUsed = snapshot.memoryUsed();
    vector<u16> mem(begin(snapshot.mem), begin(snapshot.mem) + memUsed);

    Disassembler disasm;
    auto ops = disasm.decode(mem);

    Operation stub;
    stub.offset = address ? address : snapshot.ip;

    auto it = lower_bound(begin(ops), end(ops), stub,
      [](const Operation& a, const Operation& b){ return a.offset < b.offset; });

    if (it == end(ops))
      return;

    auto from = max(begin(ops), prev(it, 3));
    auto upto = min(end(ops), prev(it, -7));

    for (auto it = from; it != upto; it++)
      disasm.format(so, *it, it->offset == stub.offset);
  }

  void
  Debugger::showRegisters(ostream& so)
  {
    auto snapshot = vm->save();

    so << setfill(' ');

    for (size_t i = 0; i < snapshot.reg.size(); i++)
      so << setw(3) << right << 'r' << i << ' ';
    so << endl;

    so << setfill('0');
    for (auto& r : snapshot.reg)
      so << hex << setw(4) << r << ' ';
    so << endl;
  }

  void
  Debugger::dumpMemory(ostream& so, u16 address, u16 size)
  {
    auto snapshot = vm->save();
    auto& mem = snapshot.mem;

    so << setfill('0') << right << hex;

    stringstream ascii;
    u16 n = 0;

    for (u16 p = address; n < size && p < mem.size(); n++, p++)
    {
      if (n % 8 == 0)
      {
        if (n > 1)
        {
          so << ' ' << ascii.str() << endl;
          ascii.str("");
        }
        so << setw(4) << p << ": ";
      }

      u16 x = mem[p];
      so << setw(4) << x << ' ';
      ascii << (x > 31 && x < 128 ? (char)x : '.');
    }

    if (n % 8)
      so << setfill(' ') << setw((8 - (n % 8)) * 5) << ' ';
    so << ' ' << ascii.str() << endl;
  }

  void
  Debugger::showStack(ostream& so, u16 size)
  {
    auto snapshot = vm->save();
    auto& stack = snapshot.stack;
    u16 address = snapshot.sp - 1;

    so << setfill('0') << hex << right;

    for (int p = address, n = 0; n < size && p >= 0; n++, p--)
    {
      so << setw(4) << p << ": " << setw(4) << stack[p] << endl;
    }
  }

  void
  Debugger::sendCommand(const string& name, u16 arg) const
  {
    zmq::socket_t socket(*context, ZMQ_PAIR);
    socket.connect(vm->messagingEndpoint());

    DebuggerCommand command = { name, arg };
    zmq::message_t message((void*)&command, sizeof(command));
    socket.send(message);
  }

  void
  Debugger::step()
  {
    sendCommand("step");
  }

  void
  Debugger::stepOut()
  {
    sendCommand("step-out");
  }

  void
  Debugger::resume()
  {
    sendCommand("resume");
  }

  void
  Debugger::breakOn(u16 address)
  {
    sendCommand("set breakpoint", address);
  }

  void
  Debugger::listBreakpoints()
  {
    sendCommand("info breakpoints");
  }

  void
  Debugger::clearBreakpoint(u16 address)
  {
    sendCommand("clear breakpoint", address);
  }

}
