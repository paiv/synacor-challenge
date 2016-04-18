
namespace paiv {

  typedef struct
  {
    u8 size;
    Op opcode;
    u16 a;
    u16 b;
    u16 c;
    u16 offset;
    string s;
    vector<u16> data;
  } Operation;


  static string
  to_hex(u16 x)
  {
    stringstream so;
    so << showbase << hex << x;
    return so.str();
  }


  class Disassembler
  {
  public:
    void disassemble(const vector<u16>& image, ostream& so);
    vector<Operation> decode(const vector<u16>& image);
    Operation decode(u16 opcode, u16 a, u16 b, u16 c);

  private:
    void format(ostream& so, Operation& op);
    string formatData(const vector<u16>& data);
    string opname(u16 opcode);
    string argname(u16 arg);
    string charof(u16 arg);
    string char_or_hex(u16 x);
    string extractAscii(const vector<Operation>& ops);
    vector<u16> extractData(const vector<Operation>& ops);
    vector<Operation> optimize(const vector<Operation>& ops);
    vector<Operation> stringData(const vector<Operation>& ops);
  };

  void
  Disassembler::disassemble(const vector<u16>& image, ostream& so)
  {
    auto ops = decode(image);
    ops = optimize(ops);
    for (auto& op : ops)
      format(so, op);
  }

  vector<Operation>
  Disassembler::decode(const vector<u16>& image)
  {
    auto size = image.size();

    vector<Operation> ops;
    ops.reserve(size / 2);

    for (u16 ip = 0; ip < size; )
    {
      u16 opcode = image[ip];
      u16 a = 0;
      u16 b = 0;
      u16 c = 0;

      if (ip + 1 < size) a = image[ip + 1];
      if (ip + 2 < size) b = image[ip + 2];
      if (ip + 3 < size) c = image[ip + 3];

      // clog << ip << ": " << opcode << endl;

      if (ip > 0x17B3)
      {
        auto op = Operation{ 1, Op::DATA, opcode };
        op.offset = ip;
        ops.push_back(op);
        ip += op.size;
      }
      else
      {
        auto op = decode(opcode, a, b, c);
        op.offset = ip;
        ops.push_back(op);
        ip += op.size;
      }
    }

    return ops;
  }

  Operation
  Disassembler::decode(u16 opcode, u16 a, u16 b, u16 c)
  {
    Operation op = { 0, (Op)opcode, a, b, c };

    switch (opcode)
    {
      case Op::HALT:
      case Op::RET:
      case Op::NOOP:
        op.size = 1;
        break;

      case Op::PUSH:
      case Op::POP:
      case Op::JMP:
      case Op::CALL:
      case Op::OUT:
      case Op::IN:
        op.size = 2;
        break;

      case Op::SET:
      case Op::JT:
      case Op::JF:
      case Op::NOT:
      case Op::RMEM:
      case Op::WMEM:
        op.size = 3;
        break;

      case Op::EQ:
      case Op::GT:
      case Op::ADD:
      case Op::MULT:
      case Op::MOD:
      case Op::AND:
      case Op::OR:
        op.size = 4;
        break;

      default:
        op.size = 1;
        op.opcode = Op::DATA;
        op.a = opcode;
        break;
    }

    return op;
  }

  void
  Disassembler::format(ostream& so, Operation& op)
  {
    so << setfill('0') << setw(4) << right << hex << uppercase << op.offset << ':';
    so << dec << setfill(' ');
    so << setw(4) << " " << setw(4) << left << opname(op.opcode);

    if (op.size > 1)
    {
      so << setw(4) << " ";
      if (op.s.size() > 0)
        so << "\"" << op.s << "\"";
      else if (op.data.size() > 0)
        so << formatData(op.data);
      else
        so << argname(op.a);
    }

    if (op.size > 2)
      so << ", " << argname(op.b);
    if (op.size > 3)
      so << ", " << argname(op.c);

    so << endl;
  }

  string
  Disassembler::argname(u16 arg)
  {
    return arg < 32768 ? to_hex(arg)
      : arg > 32775 ? "(invalid)"
      : (string("reg") + to_string(arg - 32768));
  }

  string
  Disassembler::opname(u16 opcode)
  {
    switch (opcode)
    {
      case Op::HALT:  return "halt";
      case Op::SET:   return "set";
      case Op::PUSH:  return "push";
      case Op::POP:   return "pop";
      case Op::EQ:    return "eq";
      case Op::GT:    return "gt";
      case Op::JMP:   return "jmp";
      case Op::JT:    return "jt";
      case Op::JF:    return "jf";
      case Op::ADD:   return "add";
      case Op::MULT:  return "mult";
      case Op::MOD:   return "mod";
      case Op::AND:   return "and";
      case Op::OR:    return "or";
      case Op::NOT:   return "not";
      case Op::RMEM:  return "rmem";
      case Op::WMEM:  return "wmem";
      case Op::CALL:  return "call";
      case Op::RET:   return "ret";
      case Op::OUT:   return "out";
      case Op::IN:    return "in";
      case Op::NOOP:  return "noop";
      case Op::DATA:  return "data";
    }
    return "(invalid)";
  }

  inline vector<Operation>
  Disassembler::optimize(const vector<Operation>& ops)
  {
    auto res = stringData(ops);
    return res;
  }

  inline string
  Disassembler::charof(u16 arg)
  {
    switch (arg)
    {
      case '\0':  return "\\0";
      case '\a':  return "\\a";
      case '\b':  return "\\b";
      case '\f':  return "\\f";
      case '\v':  return "\\v";
      case '\t':  return "\\t";
      case '\n':  return "\\n";
      case '\r':  return "\\r";
      case '\'':  return "\\'";
      case '\"':  return "\\\"";
      case '\\':  return "\\\\";
      default:
        if (arg < ' ')
        {
          stringstream so;
          so << "\\x" << setfill('0') << setw(2) << hex << arg;
          return so.str();
        }
        return string(1, (char)arg);
    }
  }

  string
  Disassembler::char_or_hex(u16 x)
  {
    stringstream so;

    if (x < 128)
      so << "'" << charof(x) << "'";
    else
      so << showbase << hex << x;

    return so.str();
  }

  string
  Disassembler::extractAscii(const vector<Operation>& ops)
  {
    stringstream so;
    for (auto& op : ops)
      so << charof(op.a);
    return so.str();
  }

  vector<u16>
  Disassembler::extractData(const vector<Operation>& ops)
  {
    vector<u16> res;
    res.reserve(ops.size());
    for (auto& op : ops)
      res.push_back(op.a);
    return res;
  }

  string
  Disassembler::formatData(const vector<u16>& data)
  {
    stringstream so;
    so << showbase << hex;
    for (u16 x : data)
      so << x << ' ';
    return so.str();
  }

  vector<Operation>
  Disassembler::stringData(const vector<Operation>& ops)
  {
    vector<Operation> res;
    res.reserve(ops.size());

    u8 state = 0;
    vector<Operation> group;
    u16 groupOffset;

    for (size_t i = 0; i < ops.size(); i++)
    {
      auto& op = ops[i];
      switch (state)
      {
        case 0:
          switch (op.opcode)
          {
            case Op::OUT:
              group.clear();
              group.push_back(op);
              groupOffset = op.offset;
              state = 1;
              break;
            case Op::DATA:
              group.clear();
              group.push_back(op);
              groupOffset = op.offset;
              state = op.a < 128 ? 2 : 3;
              break;
            default:
              res.push_back(op);
              break;
          }
          break;

        case 1: // ascii out
          if (op.opcode == Op::OUT)
          {
            group.push_back(op);
          }
          else
          {
            Operation newOp = { 2, Op::OUT };
            newOp.offset = groupOffset;
            newOp.s = extractAscii(group);
            res.push_back(newOp);
            i--;
            state = 0;
          }
          break;

        case 2: // ascii data
          if (op.opcode == Op::DATA && op.a < 128)
          {
            group.push_back(op);
          }
          else
          {
            Operation newOp = { 2, Op::DATA };
            newOp.offset = groupOffset;
            newOp.s = extractAscii(group);
            res.push_back(newOp);
            i--;
            state = 0;
          }
          break;

        case 3: // binary data
          if (op.opcode == Op::DATA && op.a >= 128 && group.size() < 16)
          {
            group.push_back(op);
          }
          else
          {
            Operation newOp = { 2, Op::DATA };
            newOp.offset = groupOffset;
            newOp.data = extractData(group);
            res.push_back(newOp);
            i--;
            state = 0;
          }
          break;
      }
    }

    switch (state)
    {
      case 1: // ascii out
        {
          Operation newOp = { 2, Op::OUT };
          newOp.offset = groupOffset;
          newOp.s = extractAscii(group);
          res.push_back(newOp);
        }
        break;

      case 2: // ascii data
        {
          Operation newOp = { 2, Op::DATA };
          newOp.offset = groupOffset;
          newOp.s = extractAscii(group);
          res.push_back(newOp);
        }
        break;

      case 3: // binary data
        {
          Operation newOp = { 2, Op::DATA };
          newOp.offset = groupOffset;
          newOp.data = extractData(group);
          res.push_back(newOp);
        }
        break;
    }

    return res;
  }

}
