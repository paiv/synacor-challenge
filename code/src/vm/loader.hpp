
namespace paiv
{
  class ImageLoader
  {
  public:
    vector<u16> read(const string& fileName) const
    {
      ifstream ifs(fileName, ios::binary | ios::ate);

      auto size = ifs.tellg();
      ifs.seekg(0, ios::beg);

      vector<u16> res(size / 2);
      ifs.read((char*)&res[0], size/2*2);

      return res;
    }

    template<size_t N>
    inline vector<u16>
    read(const u8 (&raw)[N]) const
    {
      return vector<u16>((u16*)&raw[0], (u16*)&raw[N/2*2]);
    }

    inline vector<u16>
    read(const vector<u8>& raw) const
    {
      auto N = raw.size();
      return vector<u16>((u16*)&raw[0], (u16*)&raw[N/2*2]);
    }
  };

}
