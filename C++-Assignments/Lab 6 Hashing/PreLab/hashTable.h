// Brian Barbu (brb9da)

#ifndef HASHTABLE_H
#define HASHTABLE_H


#include <list>
#include <vector>
#include <string>
#include <cstdlib>
#include <iostream>

using namespace std;

class hashTable {
	public:
		hashTable(int size);
		bool isPrime(unsigned int x);
		int nextPrime(unsigned int x);
		void insert(string input);
		bool isFound(string input);
		int hash(string input);
	
	private:
		int hashTableSize;
		vector<list<string>> *stack;
};

#endif
