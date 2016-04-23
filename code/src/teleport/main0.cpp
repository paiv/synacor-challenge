#include <iostream>
#include <deque>
#include <queue>
#include <stack>
#include <unordered_set>
#include <vector>

using namespace std;

#include "../vm/types.hpp"

using namespace paiv;

extern "C"
{
  u16 flash(u16 a, u16 b, u16 x, u64 max_loops);
}

namespace paiv
{
  typedef struct bfstate
  {
    u16 a, b, s1, s2;
  } bfstate;

  static inline u16
  u15add(u16 a, u16 b)
  {
    return (a + b) & 0x7fff;
  }
}

namespace std
{
  template <>
  class hash<bfstate>
  {
  public:
    size_t operator() (const bfstate& a) const
    {
      hash<u16> h;
      size_t seed = 0;
      seed ^= h((u16)a.a) + 0x9e3779b9 + (seed << 6) + (seed >> 2);
      seed ^= h((u16)a.b) + 0x9e3779b9 + (seed << 6) + (seed >> 2);
      seed ^= h((u16)a.s1) + 0x9e3779b9 + (seed << 6) + (seed >> 2);
      seed ^= h((u16)a.s2) + 0x9e3779b9 + (seed << 6) + (seed >> 2);
      return seed;
    }
  };

  template <>
  struct equal_to<bfstate>
  {
    inline bool operator() (const bfstate& a, const bfstate& b) const
    {
      return a.a == b.a && a.b == b.b && a.s1 == b.s1 && a.s2 == b.s2;
    }
  };
}

namespace paiv
{
  typedef struct
  {
    u16 a, b, x;

//     void check()                          // 0
//     {
// foo:                                      // 1
//       if (a) {
//         if (b) {
//           u16 t = a;
//           b = (b + 0x7fff) % 0x8000;
//           check();                        // 2
//           b = a;                          // 3
//           a = t;
//           a = (a + 0x7fff) % 0x8000;
//           goto foo;                       // 4
//         }
//         else {
//           a = (a + 0x7fff) % 0x8000;
//           b = x;
//           goto foo;                       // 5
//         }
//       }
//       else {
//         a = (b + 1) % 0x8000;             // 6
//       }
//     }

    u64 max_loops;
    // unordered_set<bfstate> visited;
    // bfstate bff_state;

    void bff()
    {
foo:
      if (max_loops == 0)
      {
        // clog << "hit max loops x=" << x << endl;
        a = 0xffff;
        return;
      }
      max_loops--;
      // bff_state.a = a;
      // bff_state.b = b;
      // if (visited.find(bff_state) != end(visited))
      // {
      //   max_loops = 0;
      //   a = 0xffff;
      //   return;
      // }
      // visited.insert(bff_state);

      if (a) {
        if (b) {
          u16 t = a;
          b = u15add(b, 0x7fff);
          bff();
          if (max_loops == 0) return;
          b = a;
          a = t;
          a = u15add(a, 0x7fff);
          goto foo;
        }
        else {
          a = u15add(a, 0x7fff);
          b = x;
          goto foo;
        }
      }
      else {
        a = u15add(b, 1);
      }
    }

  } checker;


  // int teleport(u16 a, u16 b, u16 x)
  // {
  //   checker chk = { a, b, x };
  //   chk.check();
  //   return chk.a;
  // }

  u16 bruteforce(u16 a, u16 b, u16 y, u64 max_loops)
  {
    u16 x = 1;
    // for (u16 x = 3; x < 0x8000; x++)
    {
      u16 r = flash(a, b, x, max_loops);
      clog << "x=" << x << " y=" << y << " r=" << r << endl;
      if (r == y)
        return x;

      // checker chk = { a, b, x, max_loops };
      // // chk.max_loops = max_loops;
      // // chk.bff_state = { a, b, 0xffff, 0xffff };
      // chk.bff();
      // if (chk.a == y)
      //   return x;
      // // if (x % 100 == 0)
      //   clog << x << " a=" << chk.a << endl;
      // // if (chk.a != 0xffff)
      // //   cout << x << "," << chk.a << endl;
    }
    return 0;
  }


  enum struct branch
  {
    b0,
    b1,
    b2,
    b3,
    b4,
    b5,
    b6,
  };

  typedef struct search_state
  {
    u16 a;
    u16 b;
    u16 x;
    branch br;
    stack<u16> st;

    inline u8 isgoal(u16 ga, u16 gb) const
    {
      return br == branch::b0 && a == ga && b == gb && st.size() == 0;
    }

    vector<search_state> children() const
    {
      vector<search_state> res;

      switch (br)
      {
        case branch::b0:
          if (st.size() > 0 && st.top() > 0)
            res.push_back({ a, b, x, branch::b2, st });
          break;

        case branch::b1:
          res.push_back({ a, b, x, branch::b4, st });
          if (x == 0)
            res.push_back({ a, b, x, branch::b5, st });
          break;

        case branch::b2:
          if (u15add(b, 1) > 0 && st.top() == a)
          {
            search_state state = { a, u15add(b, 1), x, branch::b0, st };
            state.st.pop();
            res.push_back(state);

            state.br = branch::b1;
            res.push_back(state);
          }
          break;

        case branch::b3:
          {
            search_state state = { b, 0, x, branch::b6, st };
            state.st.push(a);
            res.push_back(state);
          }
          break;

        case branch::b4:
          if (u15add(a, 1) > 0)
            res.push_back({ u15add(a, 1), b, x, branch::b3, st });
          break;

        case branch::b5:
          if (u15add(a, 1) > 0)
          {
            res.push_back({ u15add(a, 1), 0, b, branch::b0, st });
            res.push_back({ u15add(a, 1), 0, b, branch::b1, st });
          }
          break;

        case branch::b6:
          res.push_back({ 0, u15add(a, -1), x, branch::b0, st });
          res.push_back({ 0, u15add(a, -1), x, branch::b1, st });
          break;
      }

      return res;
    }

  } search_state;
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
      seed ^= h((u16)a.br) + 0x9e3779b9 + (seed << 6) + (seed >> 2);
      seed ^= h(a.a) + 0x9e3779b9 + (seed << 6) + (seed >> 2);
      seed ^= h(a.b) + 0x9e3779b9 + (seed << 6) + (seed >> 2);
      seed ^= h(a.x) + 0x9e3779b9 + (seed << 6) + (seed >> 2);
      // for (u16 x : a.st)
      //   seed ^= h(x) + 0x9e3779b9 + (seed << 6) + (seed >> 2);
      auto st = a.st;
      while (st.size() > 0)
      {
        seed ^= h(st.top()) + 0x9e3779b9 + (seed << 6) + (seed >> 2);
        st.pop();
      }
      return seed;
    }
  };

  template <>
  struct equal_to<search_state>
  {
    inline bool operator() (const search_state& a, const search_state& b) const
    {
      return a.br == b.br && a.a == b.a && a.b == b.b && a.x == b.x && a.st == b.st;
    }
  };

  ostream& operator<< (ostream& so, const search_state& a)
  {
    so << "{" << "(" << (int)a.br << "), " << a.a << ", " << a.b << ", "
      << a.x << ", " << a.st.size() << "}";
    return so;
  }
}

namespace paiv
{
  typedef queue<search_state> fringe;
  typedef unordered_set<search_state> history;

  int solve(u16 a, u16 b, u16 x)
  {
    fringe fringe;
    history visited;
    search_state state = { x, 0, 0, branch::b6 };

    fringe.push(state);

    // for (int i = 0; i < 100 && fringe.size() > 0; i++)
    while (fringe.size() > 0)
    {
      auto state = fringe.front();
      fringe.pop();

      if (visited.find(state) != end(visited))
        continue;
      visited.insert(state);

      if (visited.size() % 100000 == 0)
      {
        clog << "searched " << visited.size() << " states; stack size: " << dec << fringe.front().st.size()
          << ", x = " << hex << fringe.front().x << endl;
        if (visited.size() > 20*10000)
        {
          while (visited.size() > 10*10000)
            visited.erase(begin(visited));
        }
      }

      // clog << state << endl;

      if (state.isgoal(a, b))
        return state.x;

      for (auto& child : state.children())
      {
        // clog << "  " << child << endl;
        fringe.push(child);
      }
    }

    clog << "! nothing found" << endl;
    return 0;
  }

}



int main(int argc, char* argv[])
{
  u16 a = 4;
  u16 b = 1;
  u16 y = 6;
  u16 x = 2;

  if (argc > 2)
  {
    a = stoul(argv[1]);
    b = stoul(argv[2]);
  }
  if (argc > 3)
    x = stoul(argv[3]);


#if 1
  clog << "bruteforcing teleport..." << endl << flush;
  x = bruteforce(a, b, y, 1LL * 1100 * 1000 * 1000);
#endif

#if 0
  clog << "solving teleport..." << endl << flush;
  x = solve(a, b, y);
#endif

  clog << "x = " << x << endl;
  // clog << "checking teleport(" << x << ") = " << flush;
  //
  // u16 r = teleport(a, b, x);
  // cout << r << endl;
  // if (r != y)
  // clog << "failed" << endl;

  return 0;
}
