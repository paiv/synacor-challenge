#include <array>
#include <iomanip>
#include <iostream>
#include <fstream>
#include <numeric>
#include <sstream>
#include <vector>
#include <readline/readline.h>
#include <readline/history.h>
#include <unistd.h>
#include <fcntl.h>
#include <zmq.hpp>
#include <signal.h>
#include <sys/stat.h>

using namespace std;

#include "../vm/types.hpp"
#include "../vm/opcodes.hpp"
#include "../vm/loader.hpp"
#include "../vm/vm.cpp"
#include "../ida/disasm.cpp"
#include "../vm/debugger.cpp"
#include "commands.cpp"

using namespace paiv;

// #include "challenge.cpp"


int main(int argc, char* argv[])
{
  if (argc < 2)
  {
    cout << "usage: play <image>" << endl;
    return 0;
  }

  // parent process -> zmq -> child process [command handler]
  // child [command handler] -> vm worker thread

  // stdin -> parent process
  // parent -> pty -> child [stdin]
  // stdout <- parent
  // stdout <- child

  int fdparent = posix_openpt(O_RDWR);
  grantpt(fdparent);
  unlockpt(fdparent);

  int fdchild = open(ptsname(fdparent), O_RDWR);

  int fd = fork();

  if (fd != 0)
  {
    close(fdchild);

    zmq::context_t context;
    zmq::socket_t socket(context, ZMQ_REQ);
    socket.connect("tcp://127.0.0.1:7199");

    CommandDispatcher dispatcher(fdparent, &socket);
    Command lastCommand("");

    while (true)
    {
      usleep(42000);
      char* line = readline("> ");
      if (!line)
        break;
      add_history(line);

      Command command(line);
      free(line);

      if (command.name == "")
        command = lastCommand;

      if (!dispatcher.process(command))
        break;

      lastCommand = command;
    }

    int state;
    if (!waitpid(fd, &state, WNOHANG))
      kill(fd, SIGQUIT);
  }
  else
  {
    close(STDIN_FILENO);
    dup2(fdchild, STDIN_FILENO);
    close(fdchild);

    zmq::context_t context;
    zmq::socket_t socket(context, ZMQ_REP);
    socket.bind("tcp://*:7199");

    ImageLoader loader;
    auto image = loader.read(argv[1]);
    // vector<u8> image(begin(challenge_bin), end(challenge_bin));

    CommandHandler handler(&context, &socket, fdparent, image);
    handler.run();
  }

  cout << endl;
  return 0;
}
