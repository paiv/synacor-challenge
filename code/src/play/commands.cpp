
namespace paiv {

  // char* tokenized;
  // char* command = strsep(&line, " \t");

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

  private:
    void parse(const string& text);
  };

  void
  Command::parse(const string& text)
  {
    istringstream ss(text);
    vector<string> tokens { istream_iterator<string>(ss), istream_iterator<string>() };

    if (tokens.size() > 0)
      this->name = tokens[0];
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
    if (command.name == "exit")
    {
      return false;
    }
    else if (command.name == "run")
    {
      zmq::message_t request(3);
      memcpy(request.data(), "run", 3);
      socket->send(request);
    }
    else {
      dprintf(pty, "%s\n", command.line.c_str());
    }

    return true;
  }


  class CommandHandler
  {
  public:
    CommandHandler(SynacorVM* vm)
    {
      this->vm = vm;
    }

    u8 process(const Command& command);

  private:
    SynacorVM* vm;
  };


  u8
  CommandHandler::process(const Command& command)
  {
    if (command.name == "run")
    {
      vm->run();
    }
    return true;
  }

}
