#include <string>
#include <iostream>
#include <vector>
#include <cstdlib>
#include <random>
#include <stdexcept>
#include <thread>
#include <chrono>

#include "utils.hpp"

int N = 5;
using T = int;
int world_size;
int rank;

int get_device() {
  return rank;
}

T *input;
T *output;

void allocate_buffers() {
  input = new T[N * world_size];
  output = new T[N * world_size];
}

void initialize_input() {
  std::random_device rd;
  std::mt19937 gen(rd());
  std::uniform_int_distribution<int> d(0, N * world_size);

  for (int i = 0; i < world_size; i++) {
    for (int j = 0; j < N; j++) {
      T value = d(gen);
      *(input + N * i + j) = value;
    }
  }
}

template<typename T>
void print_buffer(T *ptr) {
  for (int i = 0; i < world_size; i++) {
    for (int j = 0; j < N; j++) {
      std::cout << ptr[N * i + j] << ", ";
    }
    std::cout << std::endl;
  }
}

void alltoall();
void allreduce();

int main(int argc, char *argv[]) {
  check(argc == 3, "Bad argument");
  world_size = std::stoi(argv[1]);
  rank = std::stoi(argv[2]);
  std::cout << "World size: " << world_size << ", " << "Rank: " << rank << std::endl;

  allocate_buffers();
  initialize_input();

  std::this_thread::sleep_for(std::chrono::seconds(rank));
  std::cout << std::endl << "Buffers initialized as:" << std::endl;
  print_buffer(input);

  allreduce();

  std::this_thread::sleep_for(std::chrono::seconds(rank));
  std::cout << std::endl << "After alltoall, buffers are:" << std::endl;
  print_buffer(output);
}
