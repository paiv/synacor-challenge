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

    u16 offset() { return off; }
    string title() { return str(chunk[0]); }
    string description() { return str(chunk[1]); }

    vector<string> exits();
    vector<Entry> links();

    string id() {
      stringstream so;
      so << setfill('0') << hex << setw(4) << off;
      return so.str();
    }

  private:
    string strref(size_t offset);
    string str(u16 offset);

  private:
    const chunk& image;
    u16 off;
    chunk chunk;
  };

  string Entry::strref(size_t offset)
  {
    return str(image[offset]);
  }

  string Entry::str(u16 offset)
  {
    u16 len = image[offset++];
    auto it = begin(image) + offset;
    string so(len, '@');
    transform(it, it + len, begin(so), [](u16 x){ return (char)x; });
    return so;
  }


  vector<string> Entry::exits()
  {
    u16 p = chunk[2];
    int n = image[p++];

    vector<string> res;

    for (; n > 0; n--)
      res.push_back(strref(p++));

    return res;
  }

  vector<Entry> Entry::links()
  {
    u16 p = chunk[3];
    int n = image[p++];

    vector<Entry> res;

    for (; n > 0; n--)
      res.push_back(Entry(image, image[p++], 4));

    return res;
  }
}


static void
walkDungeon(ostream& so, const chunk& image, u16 address)
{
  Entry entry(image, address, 4);

  queue<Entry> fringe;
  unordered_set<u16> visited;

  fringe.push(entry);

  while (fringe.size() > 0)
  {
    auto entry = fringe.front();
    fringe.pop();

    if (visited.find(entry.offset()) != end(visited))
      continue;
    visited.insert(entry.offset());

    so << '"' << entry.id() << "\" [label=\"" /*<< entry.id() << ": "*/ << entry.title() << "\"]" << endl;

    int i = 0;
    for (auto& link : entry.links())
    {
      so << '"' << entry.id() << "\" -> \"" << link.id() << "\" [label=\"" << entry.exits()[i++] << "\"]" << endl;
      if (visited.find(link.offset()) == end(visited))
        fringe.push(link);
    }
  }
}

template <size_t N>
static void
walkDungeon(ostream& so, const chunk& image, const u16 (&entries)[N])
{
  so << "digraph \"Synacore\" {" << endl;

  for (u16 entry : entries)
    walkDungeon(so, image, entry);

  so << "}" << endl;
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

  u16 entries[] = {
    0x090D,   // foothills
    0x09B8,   // headquaters
    0x09C2,   // beach, vault
  };

  stringstream so;
  walkDungeon(so, image, entries);
  cout << so.str();

  return 0;
}
