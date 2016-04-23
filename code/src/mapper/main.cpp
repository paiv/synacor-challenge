#include <fstream>
#include <iomanip>
#include <iostream>
#include <queue>
#include <sstream>
#include <vector>
#include <unordered_set>

using namespace std;

#include "../vm/types.hpp"
#include "../vm/loader.hpp"

using namespace paiv;


namespace paiv
{
  typedef vector<u16> chunk;

  class Entry
  {
  public:
    Entry(const chunk& image, u16 offset, u16 size)
      : image(image), off(offset), chunk(begin(image) + offset, begin(image) + offset + size)
    {}

    u16 offset() const { return off; }
    string title() const { return str(chunk[0]); }
    string description() const { return str(chunk[1]); }

    vector<string> exits() const;
    vector<Entry> links() const;

    string id() const {
      stringstream so;
      so << setfill('0') << hex << setw(4) << off;
      return so.str();
    }

  private:
    string strref(size_t offset) const;
    string str(u16 offset) const;

  private:
    const chunk& image;
    u16 off;
    chunk chunk;
  };

  string Entry::strref(size_t offset) const
  {
    return str(image[offset]);
  }

  string Entry::str(u16 offset) const
  {
    u16 len = image[offset++];
    auto it = begin(image) + offset;
    string so(len, '@');
    transform(it, it + len, begin(so), [](u16 x){ return (char)x; });
    return so;
  }


  vector<string> Entry::exits() const
  {
    u16 p = chunk[2];
    int n = image[p++];

    vector<string> res;

    for (; n > 0; n--)
      res.push_back(strref(p++));

    return res;
  }

  vector<Entry> Entry::links() const
  {
    u16 p = chunk[3];
    int n = image[p++];

    vector<Entry> res;

    for (; n > 0; n--)
      res.push_back(Entry(image, image[p++], 4));

    return res;
  }
}


static unordered_set<u16>
walkDungeon(ostream& so, const chunk& image, u16 address, unordered_set<u16> visited,
  const function<bool(const Entry&)>& mapper)
{
  Entry entry(image, address, 4);

  queue<Entry> fringe;
  fringe.push(entry);

  while (fringe.size() > 0)
  {
    auto entry = fringe.front();
    fringe.pop();

    if (visited.find(entry.offset()) != end(visited))
      continue;
    visited.insert(entry.offset());

    if (!mapper(entry))
      continue;

    for (auto& link : entry.links())
    {
      if (visited.find(link.offset()) == end(visited))
        fringe.push(link);
    }
  }

  return visited;
}


static void
walkDungeon(ostream& so, const chunk& image, const vector<u16>& entries)
{
  unordered_set<u16> visited;

  so << "digraph \"Synacor\" {" << endl;

  auto mapper = [&so](const Entry& entry) -> bool
  {
    so << '"' << entry.id() << "\" [label=\"" << entry.id() << ": " << entry.title() << "\"]" << endl;

    int i = 0;
    for (auto& link : entry.links())
      so << '"' << entry.id() << "\" -> \"" << link.id() << "\" [label=\"" << entry.exits()[i++] << "\"]" << endl;

    return true;
  };

  for (u16 entry : entries)
    visited = walkDungeon(so, image, entry, visited, mapper);

  so << "}" << endl;
}


enum class LockOp
{
  err = -1,
  sum = 0,
  sub = 1,
  mul = 2,
  wei = 199,
};

typedef struct
{
  u16 offset;
  LockOp op;
  u16 x;
  u16 y;
} VaultLock;

static VaultLock
vaultLock(const chunk& image, const Entry& entry)
{
  u16 handler = image[entry.offset() + 4];
  u16 x = image[handler + 6];
  u16 y = image[handler + 9];
  u16 opf = image[handler + 11];
  LockOp op = LockOp::err;

  switch (opf)
  {
    case 0x107a:
      switch (x)
      {
        case 0: op = LockOp::sum; break;
        case 1: op = LockOp::sub; break;
        case 2: op = LockOp::mul; break;
      }
      break;

    case 0x10b7:
      op = LockOp::wei;
      break;

    default:
      x = y = 0;
      break;
  }

  return VaultLock{ entry.offset(), op, x, y };
}

static string
vaultLockType(const chunk& image, const Entry& entry)
{
  auto lock = vaultLock(image, entry);

  stringstream so;

  switch (lock.op)
  {
    case LockOp::sum: so << "sum"; break;
    case LockOp::sub: so << "sub"; break;
    case LockOp::mul: so << "mul"; break;
    case LockOp::wei: so << "wei " << lock.x; break;
    default:
    case LockOp::err: so << "err"; break;
  }
  return so.str();
}

static void
vaultLocks(ostream& so, const chunk& image, u16 root, const unordered_set<u16>& stops)
{
  unordered_set<u16> visited;

  so << "digraph \"Vault Locks\" {" << endl;

  auto mapper = [&so, &stops, &image](const Entry& entry) -> bool
  {
    if (stops.find(entry.offset()) != end(stops))
      return false;


    string type = vaultLockType(image, entry);
    string title = type.size() > 0 ? type : entry.title();

    so << '"' << entry.id() << "\" [label=\""
      /*<< entry.id() << ": "*/
      << title << "\"]" << endl;

    int i = 0;
    for (auto& link : entry.links())
    {
      if (stops.find(link.offset()) == end(stops))
        so << '"' << entry.id() << "\" -> \"" << link.id() << "\" [label=\"" << entry.exits()[i++] << "\"]" << endl;
    }

    return true;
  };

  walkDungeon(so, image, root, visited, mapper);

  so << "}" << endl;
}


static void
vaultLocksData(ostream& so, const chunk& image, u16 root, const unordered_set<u16>& stops)
{
  unordered_set<u16> visited;

  auto mapper = [&so, &stops, &image](const Entry& entry) -> bool
  {
    if (stops.find(entry.offset()) != end(stops))
      return false;

    auto lock = vaultLock(image, entry);

    so << lock.offset;
    so << ", " << (int)lock.op;
    so << ", " << lock.x;
    so << ", " << lock.y;

    int i = 0;
    for (auto& link : entry.links())
    {
      if (stops.find(link.offset()) == end(stops))
      {
        so << ", " << link.offset();
        so << ", " << "\"" << entry.exits()[i++] << "\"";
      }
    }

    so << endl;
    return true;
  };

  walkDungeon(so, image, root, visited, mapper);
}


int main(int argc, char* argv[])
{
  if (argc < 2)
  {
    cout << "usage: mapper <dumpfile>" << endl;
    return 0;
  }

  ImageLoader loader;
  auto image = loader.read(argv[1]);

#if 1
  vector<u16> entries = {
    0x090D,   // foothills
    0x09B8,   // headquaters
    0x09C2,   // beach, vault
  };

  stringstream so;
  walkDungeon(so, image, entries);
  cout << so.str();
#endif

#if 0
  u16 root = 0x0A3F;  // antechamber
  unordered_set<u16> stops = { 0x09FE, 0x0A53 };

  stringstream so;
  vaultLocks(so, image, root, stops);
  // vaultLocksData(so, image, root, stops);
  cout << so.str();
#endif

  return 0;
}
