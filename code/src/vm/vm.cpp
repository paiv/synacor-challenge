
namespace paiv {

  using namespace std;


  typedef struct
  {
    string name;
    u16 arg;
  } DebuggerCommand;

  typedef struct
  {
    string name;
    string arg;
  } VmEvent;


  class SynacorVM;

  class Snapshot
  {
  public:

    void take(const SynacorVM* vm);
    void restore(SynacorVM* vm) const;

    u8 save(const string& fn);
    u8 load(const string& fn);
    u8 loadImage(const vector<u16>& image);

    string fn;

    array<u16, 16*32768> mem;
    array<u16, 8> reg;
    array<u16, 1024*1024> stack;
    u16 ip;
    u16 sp;

    u16 memoryUsed() const;
  };


  static u8 vmid_sequence;

  class SynacorVM : public enable_shared_from_this<SynacorVM>
  {
  protected:
    typedef vector<u16> Image;

    array<u16, 16*32768> mem;
    array<u16, 8> reg;
    array<u16, 1024*1024> stack;
    u16 ip;
    u16 sp;

    friend class Snapshot;
    friend class Debugger;

  public:
    SynacorVM() : id(vmid_sequence++), ip(0), sp(0), halted(false), stopped(false) {
      receiveEndpoint = string("inproc://debug") + to_string(id);
      reportEndpoint = string("inproc://vm") + to_string(id);
      mem.fill(0);
      reg.fill(0);
      stack.fill(0);
    }

    template<size_t N>
    void exec(u16 (&image)[N]);
    void exec(Image& image);

    void load(Image& image);
    void run(zmq::socket_t* controller = nullptr, zmq::socket_t* publisher = nullptr);
    void step();
    void halt() { stopped = halted = true; }

    Snapshot save();
    void load(const Snapshot& snapshot);

    string messagingEndpoint() const { return receiveEndpoint; }
    string reportingEndpoint() const { return reportEndpoint; }

  private:
    u8 dispatch(u16 opcode, u16 a, u16 b, u16 c);
    u16 xnum(u16 x);
    u16& regr(u16 x);
    void report(zmq::socket_t* publisher, const string& name, const string& arg = "") const;

  private:
    u8 id;
    string receiveEndpoint;
    string reportEndpoint;
    u8 halted;
    u8 stopped;
    u16 lastOp;
    vector<u16> executionBreakpoints;
  };


  template<size_t N>
  void
  SynacorVM::exec(u16 (&image)[N])
  {
    Image v(begin(image), end(image));
    exec(v);
  }

  void
  SynacorVM::exec(Image& image)
  {
    load(image);
    run();
  }

  void
  SynacorVM::run(zmq::socket_t* controller, zmq::socket_t* publisher)
  {
    zmq::message_t message;
    u8 breakpointNext = false;
    u8 breakpointRet = false;

    while (!halted)
    {
      if (controller && controller->recv(&message, ZMQ_DONTWAIT))
      {
        DebuggerCommand command = *message.data<DebuggerCommand>();

        if (command.name == "step")
        {
          breakpointNext = true;
          stopped = false;
          step();
        }
        else if (command.name == "step-out")
        {
          breakpointRet = true;
          stopped = false;
          step();
        }
        else if (command.name == "stop")
        {
          stopped = true;
        }
        else if (command.name == "resume")
        {
          stopped = false;
          step();
        }
        else if (command.name == "info breakpoints")
        {
          string bps = accumulate(begin(executionBreakpoints), end(executionBreakpoints), string(),
            [](const string& a, u16 b) {
              stringstream so;
              so << a << ' ' << setfill('0') << setw(4) << hex << b;
              return so.str();
            });

          report(publisher, "breakpoints", bps);
        }
        else if (command.name == "set breakpoint")
        {
          executionBreakpoints.push_back(command.arg);
        }
        else if (command.name == "clear breakpoint")
        {
          auto it = find(begin(executionBreakpoints), end(executionBreakpoints), command.arg);
          if (it != end(executionBreakpoints))
            executionBreakpoints.erase(it);
        }
      }

      if (!stopped)
      {
        if (breakpointNext
          || find(begin(executionBreakpoints), end(executionBreakpoints), ip) != end(executionBreakpoints)
          || (breakpointRet && lastOp == Op::RET))
        {
          breakpointNext = false;
          breakpointRet = false;
          stopped = true;
          report(publisher, "stopped");
        }
        else
        {
          step();
        }
      }
      else
      {
        usleep(1000);
      }
    }
  }

  void
  SynacorVM::report(zmq::socket_t* publisher, const string& name, const string& arg) const
  {
    if (publisher)
    {
      VmEvent event = { name, arg };
      zmq::message_t message((void*)&event, sizeof(event));
      publisher->send(message);
    }
  }

  void
  SynacorVM::step()
  {
    if (!dispatch(mem[ip], mem[ip + 1], mem[ip + 2], mem[ip + 3]))
      halted = true;
  }

  inline u16
  SynacorVM::xnum(u16 x)
  {
    return x < 32768 ? x : x > 32775 ? 0 : reg[x - 32768];
  }

  inline u16&
  SynacorVM::regr(u16 x)
  {
    return reg[x - 32768];
  }

  u8
  SynacorVM::dispatch(u16 opcode, u16 a, u16 b, u16 c)
  {
    switch (opcode)
    {
      case Op::HALT:
        return false;

      case Op::SET:
        regr(a) = xnum(b);
        ip += 3;
        break;

      case Op::PUSH:
        stack[sp++] = xnum(a);
        ip += 2;
        break;

      case Op::POP:
        if (sp == 0) return false;
        regr(a) = stack[--sp];
        ip += 2;
        break;

      case Op::EQ:
        regr(a) = xnum(b) == xnum(c);
        ip += 4;
        break;

      case Op::GT:
        regr(a) = xnum(b) > xnum(c);
        ip += 4;
        break;

      case Op::JMP:
        ip = xnum(a);
        break;

      case Op::JT:
        ip = xnum(a) != 0 ? xnum(b) : ip + 3;
        break;

      case Op::JF:
        ip = xnum(a) == 0 ? xnum(b) : ip + 3;
        break;

      case Op::ADD:
        regr(a) = (xnum(b) + xnum(c)) % 32768;
        ip += 4;
        break;

      case Op::MULT:
        regr(a) = (xnum(b) * xnum(c)) % 32768;
        ip += 4;
        break;

      case Op::MOD:
        regr(a) = xnum(b) % xnum(c);
        ip += 4;
        break;

      case Op::AND:
        regr(a) = xnum(b) & xnum(c);
        ip += 4;
        break;

      case Op::OR:
        regr(a) = xnum(b) | xnum(c);
        ip += 4;
        break;

      case Op::NOT:
        regr(a) = ~xnum(b) & 0x7FFF;
        ip += 3;
        break;

      case Op::RMEM:
        regr(a) = mem[xnum(b)];
        ip += 3;
        break;

      case Op::WMEM:
        mem[xnum(a)] = xnum(b);
        ip += 3;
        break;

      case Op::CALL:
        stack[sp++] = ip + 2;
        ip = xnum(a);
        break;

      case Op::RET:
        if (sp == 0) return false;
        ip = stack[--sp];
        break;

      case Op::OUT:
        ip += 2;
        printf("%c", xnum(a));
        break;

      case Op::IN:
        regr(a) = getchar();
        ip += 2;
        break;

      case Op::NOOP:
        ip++;
        break;

      default:
        cerr << "unhandled opcode " << opcode << endl;
        __builtin_trap();
        break;
    }

    lastOp = opcode;

    return true;
  }


  Snapshot
  SynacorVM::save()
  {
    Snapshot snapshot;
    snapshot.take(this);
    return snapshot;
  }

  void
  SynacorVM::load(const Snapshot& snapshot)
  {
    snapshot.restore(this);
  }

  void
  SynacorVM::load(Image& image)
  {
    Snapshot snapshot;
    snapshot.loadImage(image);
    load(snapshot);
  }


  void
  Snapshot::take(const SynacorVM* vm)
  {
    ip = vm->ip;
    sp = vm->sp;
    mem = vm->mem;
    reg = vm->reg;
    stack = vm->stack;
  }

  void
  Snapshot::restore(SynacorVM* vm) const
  {
    vm->ip = ip;
    vm->sp = sp;
    vm->mem = mem;
    vm->reg = reg;
    vm->stack = stack;
  }

  typedef union
  {
    char chars[8];
    u64 word;
  } Signature;

  static const Signature SIGNv1 = { "SYNACOR" };

  u16
  Snapshot::memoryUsed() const
  {
    auto it = find_if(mem.rbegin(), mem.rend(), [](u16 x){ return x != 0; });
    return distance(it, mem.rend());
  }

  u8
  Snapshot::save(const string& fn)
  {
    ofstream ofs(fn, ios::binary | ios::trunc);
    if (!ofs.good())
      return false;

    u16 memUsed = memoryUsed();

    ofs.write(SIGNv1.chars, sizeof(SIGNv1));
    ofs.write((char*)&reg[0], reg.size() * 2);
    ofs.write((char*)&ip, 2);
    ofs.write((char*)&sp, 2);
    ofs.write((char*)&stack[0], sp * 2);
    ofs.write((char*)&memUsed, 2);
    ofs.write((char*)&mem[0], memUsed * 2);

    return true;
  }

  u8
  Snapshot::load(const string& fn)
  {
    ifstream ifs(fn, ios::binary | ios::ate);
    if (!ifs.good())
      return false;

    auto size = ifs.tellg();
    ifs.seekg(0, ios::beg);

    size_t runlen = sizeof(Signature);
    if (size > runlen)
    {
      Signature sign;
      ifs.read(&sign.chars[0], sizeof(Signature));
      if (sign.word != SIGNv1.word) return false;
    }

    runlen += reg.size() * 2;
    if (size > runlen )
    {
      ifs.read((char*)&reg[0], reg.size() * 2);
    }

    runlen += 4;
    if (size > runlen)
    {
      ifs.read((char*)&ip, 2);
      ifs.read((char*)&sp, 2);
    }

    runlen += sp * 2;
    if (size > runlen )
    {
      stack.fill(0);
      ifs.read((char*)&stack[0], sp * 2);
    }

    u16 memUsed;
    runlen += 2;
    if (size > runlen)
    {
      ifs.read((char*)&memUsed, 2);
    }

    runlen += memUsed * 2;
    if (size >= runlen )
    {
      mem.fill(0);
      ifs.read((char*)&mem[0], memUsed * 2);

      this->fn = fn;
      return true;
    }

    return false;
  }

  u8
  Snapshot::loadImage(const vector<u16>& image)
  {
    ip = 0;
    sp = 0;
    reg.fill(0);
    mem.fill(0);
    stack.fill(0);
    copy(begin(image), end(image), begin(mem));
    return true;
  }

}
