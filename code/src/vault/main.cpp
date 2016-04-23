#include <iostream>
#include <queue>
#include <vector>
#include <unordered_set>

using namespace std;

#include "../vm/types.hpp"

using namespace paiv;


namespace paiv
{
  enum class LockOp
  {
    err = -1,
    sum = 0,
    sub = 1,
    mul = 2,
    wei = 199,
  };

  typedef struct VaultLock
  {
    u16 offset;
    LockOp op;
    u16 x;
    u16 y;
    u16 link1;
    string exit1;
    u16 link2;
    string exit2;
    u16 link3;
    string exit3;
    u16 link4;
    string exit4;
    const VaultLock* node1;
    const VaultLock* node2;
    const VaultLock* node3;
    const VaultLock* node4;
  } VaultLock;


  static void
  buildGraph(vector<VaultLock>& locks)
  {
    auto getNode = [&locks](u16 offset) -> const VaultLock*
    {
      auto it = find_if(begin(locks), end(locks), [offset](const VaultLock& lock)
        { return lock.offset == offset; });
      return &*it;
    };

    for (auto& lock : locks)
    {
      if (lock.link1) lock.node1 = getNode(lock.link1);
      if (lock.link2) lock.node2 = getNode(lock.link2);
      if (lock.link3) lock.node3 = getNode(lock.link3);
      if (lock.link4) lock.node4 = getNode(lock.link4);
    }
  }


  typedef struct search_state
  {
    u16 weight;
    u16 goal_weight;
    u16 goal_pos;
    const VaultLock* pos;
    vector<u16> pathids;
    vector<string> path;
    u8 terminal;

    bool isgoal() const { return weight == goal_weight && pos->offset == goal_pos; }

    search_state walk(const VaultLock* link, const string& door) const;

    vector<search_state> children() const
    {
      vector<search_state> res;
      if (terminal)
        return res;
      if (pos->node1) res.push_back(walk(pos->node1, pos->exit1));
      if (pos->node2) res.push_back(walk(pos->node2, pos->exit2));
      if (pos->node3) res.push_back(walk(pos->node3, pos->exit3));
      if (pos->node4) res.push_back(walk(pos->node4, pos->exit4));
      return res;
    }
  } search_state;

  search_state
  search_state::walk(const VaultLock* link, const string& door) const
  {
    search_state next = *this;
    next.pos = link;
    next.pathids.push_back(link->offset);
    next.path.push_back(door);

    if (link->offset == goal_pos)
      next.terminal = true;

    switch (link->op)
    {
      case LockOp::wei:
        switch (pos->op)
        {
          case LockOp::sum:
            next.weight = (weight + link->x) & 0x7fff;
            if (next.weight < weight)
              next.terminal = true;
            break;

          case LockOp::sub:
            if (weight < link->x)
              next.terminal = true;
            next.weight = (weight - link->x) & 0x7fff;
            break;

          case LockOp::mul:
            next.weight *= link->x;
            if (next.weight > 0x7fff)
              next.terminal = true;
            next.weight &= 0x7fff;
            break;

          default:
            break;
        }
        break;

      default:
        break;
    }

    return next;
  }


  static ostream&
  print(ostream& so, const vector<string>& path)
  {
    for (auto& step : path)
      so << step << " ";
    return so;
  }


  typedef queue<search_state> fringe;
  typedef unordered_set<search_state> history;
}


namespace std
{
  template <>
  class hash<search_state>
  {
  public:
    size_t operator() (const search_state& a) const
    {
      hash<u16> h;
      size_t seed = 0;
      seed ^= h(a.weight) + 0x9e3779b9 + (seed << 6) + (seed >> 2);
      seed ^= h(a.pos->offset) + 0x9e3779b9 + (seed << 6) + (seed >> 2);
      return seed;
    }
  };

  template <>
  struct equal_to<search_state>
  {
    inline bool operator() (const search_state& a, const search_state& b) const
    {
      return a.weight == b.weight && a.pos->offset == b.pos->offset;
    }
  };

  ostream& operator<< (ostream& so, const search_state& a)
  {
    so << "{ weight=" << a.weight << " at " << a.pos->offset << ": ";
    for (auto& step : a.path)
      so << step << " ";
    so << "}";
    return so;
  }
}


namespace paiv
{
  static vector<string>
  force(const vector<VaultLock>& locks)
  {
    u16 weight = 22;
    u16 goal = 30;

    fringe fringe;
    history visited;
    search_state state = { weight, goal, 2578, &locks[0] };

    fringe.push(state);

    while (fringe.size() > 0)
    {
      auto state = fringe.front();
      fringe.pop();

      if (visited.find(state) != end(visited))
        continue;
      visited.insert(state);

      // clog << state << endl;

      if (state.isgoal())
        return state.path;

      for (auto& child : state.children())
      {
        fringe.push(child);
        // clog << "  " << child << endl;
      }
    }

    clog << "! nothing found" << endl;
    return vector<string>();
  }


  vector<VaultLock> locks = {
    { 2623, LockOp::err, 0, 0, 2603, "north", 2628, "east" },
    { 2603, LockOp::sum, 0, 8, 2583, "north", 2608, "east", 2623, "south" },
    { 2628, LockOp::sub, 1, 12, 2608, "north", 2633, "east", 2623, "west" },
    { 2583, LockOp::wei, 4, 4, 2563, "north", 2588, "east", 2603, "south" },
    { 2608, LockOp::wei, 4, 9, 2588, "north", 2613, "east", 2628, "south", 2603, "west" },
    { 2633, LockOp::wei, 9, 13, 2613, "north", 2638, "east", 2628, "west" },
    { 2563, LockOp::mul, 2, 0, 2568, "east", 2583, "south" },
    { 2588, LockOp::mul, 2, 5, 2568, "north", 2593, "east", 2608, "south", 2583, "west" },
    { 2613, LockOp::sub, 1, 10, 2593, "north", 2618, "east", 2633, "south", 2608, "west" },
    { 2638, LockOp::mul, 2, 14, 2618, "north", 2633, "west" },
    { 2568, LockOp::wei, 8, 1, 2573, "east", 2588, "south", 2563, "west" },
    { 2593, LockOp::wei, 11, 6, 2573, "north", 2598, "east", 2613, "south", 2588, "west" },
    { 2618, LockOp::wei, 18, 11, 2598, "north", 2638, "south", 2613, "west" },
    { 2573, LockOp::sub, 1, 2, 2578, "east", 2593, "south", 2568, "west" },
    { 2598, LockOp::mul, 2, 7, 2578, "north", 2618, "south", 2593, "west" },
    { 2578, LockOp::wei, 1, 3, 2598, "south", 2573, "west" },
  };
}



int main(int argc, char* argv[])
{
  clog << "forcing locks..." << endl;

  buildGraph(locks);
  auto path = force(locks);

  if (path.size() > 0)
    print(cout, path) << endl;

  return 0;
}
