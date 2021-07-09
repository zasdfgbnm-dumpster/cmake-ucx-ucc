#include <iostream>
#include <string>
#include <vector>
#include <stdexcept>

struct Store {
  void set(const std::string &key, const std::vector<char> &value);
  std::vector<char> get(const std::string &key);
  bool check(const std::vector<std::string>& keys);
  bool verbose = false;
};

std::ostream &operator<<(std::ostream &os, const std::vector<char> &value);
std::ostream &operator<<(std::ostream &os, const std::vector<std::string> &value);

inline void check(bool condition, std::string msg = "") {
  if (!condition) {
    throw std::runtime_error(msg);
  }
}
