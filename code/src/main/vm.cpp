
namespace paiv {

  using namespace std;


  class ImageLoader
  {
  public:
    vector<u16> read(string fileName)
    {
      ifstream ifs(fileName, ios::binary | ios::ate);

      auto size = ifs.tellg();
      ifs.seekg(0, ios::beg);

      vector<u16> res(size / 2);
      ifs.read((char*)&res[0], size);

      return res;
    }
  };


  class SynacorVM
  {
  protected:
    typedef vector<u16> Image;

    array<u16, 16*32768> mem;
    array<u16, 8> reg;
    array<u16, 1024*1024> stack;
    u16 ip;
    u16 sp;

  public:
    SynacorVM();

    template<size_t N>
    void exec(u16 (&image)[N]);

    void exec(Image& image);

    void load(Image& image);
    void run();

  private:
    u8 dispatch(u16 opcode, u16 a, u16 b, u16 c);
    u16 xnum(u16 x);
    u16& regr(u16 x);
    void dump(string fn);
  };

  SynacorVM::SynacorVM()
    : ip(0), sp(0)
  {
  }

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
    // dump("loaded");
    run();
  }

  void
  SynacorVM::load(Image& image)
  {
    copy(begin(image), end(image), begin(mem));
    ip = 0;
    sp = 0;
  }

  void
  SynacorVM::run()
  {
    for (u8 running = true; running; )
    {
      running = dispatch(
        mem[ip],
        mem[ip + 1],
        mem[ip + 2],
        mem[ip + 3]);
    }
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
    // clog << ip << ": " << opcode << ' ' << a << ' ' << b << endl;

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
        // dump("oninput");
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

    return true;
  }

  void
  SynacorVM::dump(string fn)
  {
    ofstream ofs(string("dumps/") + fn);
    ofs.write((char*)&mem[0], mem.size() * 2);
  }

}
