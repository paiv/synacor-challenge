#include <array>
#include <iostream>
#include <fstream>
#include <sstream>
#include <vector>
#include <readline/readline.h>
#include <readline/history.h>
#include <unistd.h>
#include <fcntl.h>
#include <zmq.hpp>
#include <signal.h>

#include "../vm/types.hpp"
#include "../vm/opcodes.hpp"
#include "../vm/vm.cpp"
#include "commands.cpp"

using namespace std;
using namespace paiv;

#include "challenge.cpp"


static void*
startvm(void* arg)
{
  ImageLoader loader;
  auto image = loader.read(challenge_bin);

  SynacorVM* vm = (SynacorVM*)arg;
  vm->load(image);

  return nullptr;
}


int main(int argc, char* argv[])
{
// read: pseudo-terminal http://rachid.koucha.free.fr/tech_corner/pty_pdip.html

  int fdparent = posix_openpt(O_RDWR);
  grantpt(fdparent);
  unlockpt(fdparent);

  int fdchild = open(ptsname(fdparent), O_RDWR);

  int fd = fork();


  if (fd != 0)
  {
    close(fdchild);

    zmq::context_t context(1);
    zmq::socket_t socket(context, ZMQ_REQ);
    socket.connect("tcp://127.0.0.1:7199");

    CommandDispatcher dispatcher(fdparent, &socket);

    while (true)
    {
      usleep(50000);
      char* line = readline("> ");
      add_history(line);

      if (!dispatcher.process(Command(line)))
      {
        int state;
        if (!waitpid(fd, &state, WNOHANG))
          kill(fd, SIGQUIT);
        break;
      }
    }
  }
  else
  {
    close(fdparent);
    close(STDIN_FILENO);
    dup2(fdchild, STDIN_FILENO);
    close(fdchild);

    zmq::context_t context(1);
    zmq::socket_t socket(context, ZMQ_REP);
    socket.bind("tcp://*:7199");

    SynacorVM vm;

    pthread_t worker;
    pthread_create(&worker, nullptr, startvm, &vm);

    CommandHandler handler(&vm);

    while (true)
    {
      zmq::message_t request;
      socket.recv(&request);

      string line((const char*)request.data(), request.size());
      if (!handler.process(Command(line)))
        break;
    }
  }

  return 0;
}
