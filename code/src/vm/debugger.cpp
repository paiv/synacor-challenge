
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

    void breakNext();

  private:
    zmq::context_t* context;
    SynacorVM* vm;

  private:
    void sendCommand(const string& command) const;
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
  Debugger::sendCommand(const string& command) const
  {
    zmq::socket_t socket(*context, ZMQ_PAIR);
    socket.connect(vm->messagingEndpoint());

    zmq::message_t message(command.c_str(), command.size());
    socket.send(message);
  }

  void
  Debugger::breakNext()
  {
    sendCommand("step");
  }

}
