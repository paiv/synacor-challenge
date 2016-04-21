
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
    void showRegisters(ostream& so);

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
    auto snapshot = vm->save();
    u16 memUsed = snapshot.memoryUsed();
    vector<u16> mem(begin(snapshot.mem), begin(snapshot.mem) + memUsed);

    Disassembler disasm;
    auto ops = disasm.decode(mem);

    Operation stub;
    stub.offset = snapshot.ip;

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

    for (size_t i = 0; i < snapshot.reg.size(); i++)
      so << setw(3) << right << 'r' << i << ' ';
    so << endl;

    so << setfill('0');
    for (auto& r : snapshot.reg)
      so << hex << setw(4) << r << ' ';
    so << endl;
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
