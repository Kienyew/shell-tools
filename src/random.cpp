// create a random array of integers and output in accord to python list's format

#include <random>
#include <iostream>
#include <string>
#include <vector>
#include <exception>
#include <cstdlib>
#include <chrono>
using namespace std;

template <typename It>
string to_string(It begin, It end) {
    string result = "[";

    while (begin != end) {
        result += to_string(*begin) + ", ";
        ++begin;
    }

    if (result.size() != 1) {
        result.pop_back();
        result.pop_back();
    }

    result.push_back(']');
    return result;

}

default_random_engine rand_engine;
void usage() {
	cerr << "usage: random min_bound max_bound count" << endl;
}

int main(int argc, char* argv[]) {
	if (argc != 4) {
		usage();
		exit(1);
	}

	unsigned seed = chrono::system_clock::now().time_since_epoch().count();
	rand_engine.seed(seed);

	long min_bound;
	long max_bound;
	long count;

	try {
		min_bound = stol(argv[1]);
		max_bound = stol(argv[2]);
		count = stol(argv[3]);
	} catch (const invalid_argument& err) {
		cerr << "invalid argument: " << err.what() << endl;
		exit(2);
	}

	uniform_int_distribution<long> distribution(min_bound, max_bound);
	vector<long> nums;
	nums.reserve(count);
	for (long i = 0; i < count; ++i) {
		nums.push_back(distribution(rand_engine));
	}
	cout << to_string(nums.cbegin(), nums.cend()) << endl;
}

