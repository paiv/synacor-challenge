#include <iostream>

using namespace std;

#include "../vm/types.hpp"

using namespace paiv;


namespace paiv
{
  template<typename T>
  T ack15(u16 m, u16 n, u16 x)
  {
    function<T(u16,T)> ack = [x, &ack](u16 m, T n) -> T {

      switch (m)
      {
        case 0: return n + 1;
        // case 1: return n + 2;
        case 1: return n + x + 1;
        // case 2: return 3 + 2 * n;
        case 2: return (n + 2) * x + n + 1;
        // case 3: return 5 + 8 * (pow(T(2), (u16)n) - 1);
        default:
          return n == 0 ? ack(m - 1, x)
            : ack(m - 1, ack(m, n - 1));
      }

    };

    return ack(m, n);
  }

  template <typename T>
  u16 bruteforce(u16 m, u16 n, u16 x, u16 y)
  {
    if (x > 0)
      return ((u16) ack15<T>(m, n, x)) & 0x7fff;

    for (u16 x = 0; x < 0x8000; x++)
    {
      u16 r = ((u16) ack15<T>(m, n, x)) & 0x7fff;
      if (r == y)
        return x;
    }
    return 0;
  }
}



int main(int argc, char* argv[])
{
  u16 m = 4;
  u16 n = 1;
  u16 y = 6;
  u16 x = 0;

  if (argc > 2)
  {
    m = stoul(argv[1]);
    n = stoul(argv[2]);
  }
  if (argc > 3)
    x = stoul(argv[3]);

#if 0
  clog << "ack15(" << m << ", " << n << ") = " << flush;
  auto r = ack15<u16>(m, n, x);
  clog << dec << r << endl;
  return 0;
#endif

  clog << "bruteforcing teleporter..." << endl << flush;
  x = bruteforce<u16>(m, n, x, y);

  clog << "x = " << x << " (" << showbase << hex << x << ")" << endl;

  return 0;
}
