
namespace paiv {


  static string
  availableFilename(const string& prefix)
  {
    string fn;
    for (int i = 0; i < 0x10000 ; i++)
    {
      stringstream so;
      so << prefix << setfill('0') << setw(4) << hex << i;
      fn = so.str();
      struct stat params;
      if (stat(fn.c_str(), &params) != 0)
        return fn;
    }
    return fn;
  }


  class Command
  {
  public:
    Command(const string& text)
      : line(text)
    {
      parse(text);
    }

    string line;
    string name;
    vector<string> args;

  private:
    void parse(const string& text);
  };

  void
  Command::parse(const string& text)
  {
    istringstream ss(text);
    vector<string> tokens { istream_iterator<string>(ss), istream_iterator<string>() };

    if (tokens.size() > 0)
      name = tokens[0];
    if (tokens.size() > 1)
      copy(begin(tokens) + 1, end(tokens), back_inserter(args));
  }


  class CommandDispatcher
  {
  public:
    CommandDispatcher(int pty, zmq::socket_t* socket)
    {
      this->pty = pty;
      this->socket = socket;
    }

    u8 process(const Command& command);

  private:
    int pty;
    zmq::socket_t* socket;
  };


  u8
  CommandDispatcher::process(const Command& command)
  {
    const string& name = command.name;

    static const char* commands[] = { "save", "load", "restore", "restart", "reset",
      "di", "dis", "disassemble", "reg", "regs", "registers", "s", "si", "step", "c", "cont",
      "b", "break", "clear", "fin", "finish", "m", "mem", "memory", "stack", "write" };

    if (name == "q" || name == "quit" || name == "exit")
    {
      return false;
    }
    else if (find(begin(commands), end(commands), name) != end(commands))
    {
      const string& line = command.line;
      zmq::message_t request(line.c_str(), line.size());
      socket->send(request);

      zmq::message_t reply;
      socket->recv(&reply);
    }
    else {
      dprintf(pty, "%s\n", command.line.c_str());
    }

    return true;
  }


  typedef struct
  {
    SynacorVM* vm;
    zmq::context_t* context;
  } WorkerArgs;


  static void*
  vmworker(void* obj)
  {
    WorkerArgs* args = (WorkerArgs*)obj;

    shared_ptr<SynacorVM> vm = args->vm->shared_from_this();

    zmq::socket_t receiver(*args->context, ZMQ_PAIR);
    receiver.bind(vm->messagingEndpoint());

    zmq::socket_t publisher(*args->context, ZMQ_PUB);
    publisher.bind(vm->reportingEndpoint());

    vm->run(&receiver, &publisher);

    return nullptr;
  }


  class CommandHandler
  {
  public:
    CommandHandler(zmq::context_t* context, zmq::socket_t* socket, int pty, const vector<u8>& image)
      : context(context), socket(socket), pty(pty), worker(0), baseImage(image)
    {
    }

    void run();

    u8 resetWorker(const string& fn = "");
    u8 process(const Command& command);
    void handle(const VmEvent& event);

  private:
    shared_ptr<SynacorVM> vm;
    zmq::context_t* context;
    zmq::socket_t* socket;
    unique_ptr<zmq::socket_t> debugEvents;
    int pty;
    const vector<u8>& baseImage;
    pthread_t worker;
  };


  u8
  CommandHandler::resetWorker(const string& fn)
  {
    if (worker)
    {
      vm->halt();
      vm = nullptr;

      dprintf(pty, "\n\n");
      pthread_join(worker, nullptr);

      debugEvents = nullptr;
      worker = 0;
      int c;
      while ((c = getchar()) != '\n' && c != EOF) ;
    }

    if (!vm)
    {
      vm = make_shared<SynacorVM>();

      debugEvents = unique_ptr<zmq::socket_t>(new zmq::socket_t(*context, ZMQ_SUB));
      debugEvents->connect(vm->reportingEndpoint());
      debugEvents->setsockopt(ZMQ_SUBSCRIBE, "", 0);
    }

    Snapshot snapshot;
    if (fn.size() > 0)
    {
      if (!snapshot.load(fn))
      {
        cerr << "failed to load snapshot " << fn << endl;
        return false;
      }
    }
    else
    {
      ImageLoader loader;
      snapshot.loadImage(loader.read(baseImage));
    }

    vm->load(snapshot);

    WorkerArgs args = { vm.get(), context };
    pthread_t tid;
    if (pthread_create(&tid, nullptr, vmworker, &args) == 0)
    {
      worker = tid;
      return true;
    }

    return false;
  }

  void
  CommandHandler::run()
  {
    vector<zmq::pollitem_t> items;

    while (true)
    {
      if (!worker)
      {
        resetWorker();
      }

      items.clear();
      items.push_back({ (void*)*socket, 0, ZMQ_POLLIN, 0 });
      if (debugEvents)
        items.push_back({ (void*)*debugEvents.get(), 0, ZMQ_POLLIN, 0 });

      zmq::poll(items);

      if (items[0].revents & ZMQ_POLLIN)
      {
        zmq::message_t message;
        socket->recv(&message);

        string line((const char*)message.data(), message.size());

        u8 done = !process(Command(line));

        zmq::message_t reply;
        socket->send(reply);

        if (done) break;
      }

      if (debugEvents && (items[1].revents & ZMQ_POLLIN))
      {
        zmq::message_t message;
        debugEvents->recv(&message);

        VmEvent event = *message.data<VmEvent>();
        handle(event);
      }
    }
  }

  u8
  CommandHandler::process(const Command& command)
  {
    const string& name = command.name;

    if (name == "save")
    {
      mkdir("saves", S_IRWXU | S_IRWXG | S_IROTH | S_IXOTH);
      auto snapshot = vm->save();
      snapshot.save(availableFilename("saves/save"));
    }
    else if (name == "restart" || name == "reset")
    {
      resetWorker();
    }
    else if (name == "load" || name == "restore")
    {
      if (command.args.size() > 0)
      {
        string fn = command.args[0];
        if (resetWorker(fn))
        {
          dprintf(pty, "look\n");
        }
      }
    }
    else if (name == "di" || name == "dis" || name == "disassemble")
    {
      Debugger dbg(context, vm.get());
      if (command.args.size() > 0)
      {
        u16 address = stoul(command.args[0], 0, 16);
        dbg.disassemble(cout, address);
      }
      else
      {
        dbg.disassemble(cout);
      }
    }
    else if (name == "reg" || name == "regs" || name == "registers")
    {
      Debugger dbg(context, vm.get());
      dbg.showRegisters(cout);
    }
    else if (name == "m" || name == "mem" || name == "memory")
    {
      if (command.args.size() > 0)
      {
        Debugger dbg(context, vm.get());
        u16 address = stoul(command.args[0], 0, 16);
        u16 size = 16;
        if (command.args.size() > 1)
          size = stoul(command.args[1], 0, 16);
        dbg.dumpMemory(cout, address, size);
      }
    }
    else if (name == "write")
    {
      if (command.args.size() > 1)
      {
        Debugger dbg(context, vm.get());
        u16 value = stoul(command.args[1], 0, 16);
        if (command.args[0][0] == 'r')
        {
          u16 r = stoul(&command.args[0][1], 0, 16);
          dbg.setRegister(r, value);
        }
        else
        {
          u16 address = stoul(command.args[0], 0, 16);
          dbg.writeMemory(address, value);
        }
      }
    }
    else if (name == "stack")
    {
      Debugger dbg(context, vm.get());
      dbg.showStack(cout);
    }
    else if (name == "s" || name == "si" || name == "step")
    {
      Debugger dbg(context, vm.get());
      dbg.step();
    }
    else if (name == "c" || name == "cont")
    {
      Debugger dbg(context, vm.get());
      dbg.resume();
    }
    else if (name == "b" || name == "break")
    {
      Debugger dbg(context, vm.get());

      if (command.args.size() > 0)
      {
        u16 a = stoul(command.args[0], 0, 16);
        dbg.breakOn(a);
      }
      else
      {
        dbg.listBreakpoints();
      }
    }
    else if (name == "clear")
    {
      Debugger dbg(context, vm.get());

      if (command.args.size() > 0)
      {
        u16 a = stoul(command.args[0], 0, 16);
        dbg.clearBreakpoint(a);
      }
    }
    else if (name == "fin" || name == "finish")
    {
      Debugger dbg(context, vm.get());
      dbg.stepOut();
    }
    else
    {
      cerr << "handler: unhandled " << command.line << endl;
    }
    return true;
  }

  void
  CommandHandler::handle(const VmEvent& event)
  {
    if (event.name == "stopped")
    {
      Debugger dbg(context, vm.get());
      dbg.disassemble(cout);
    }
    else if (event.name == "breakpoints")
    {
      cout << "breakpoints: " << event.arg << endl;
    }
  }

}
