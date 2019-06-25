//Brian Barbu (brb9da)

#include "hashTable.h"

using namespace std;

hashTable::hashTable(int size){
	if(isPrime(size)){
		hashTableSize = size * 2;
	}
	else{
		hashTableSize = nextPrime(size * 2);
	}
	stack = new vector<list<string>>;
	for(int i = 0; i< hashTableSize; i++){
		list<string> nextval;
		(*stack).push_back(nextval);
	}
}
bool hashTable::isPrime(unsigned int x){
	if(x < 2){
		return false;
	}
	else if(x ==2){
		return true;
	}
	//all even
	else if(x % 2 == 0){
		return false;
	}
	for(int i = 3; i * i <= x; i+=2){
		if(x % i == 0){
			return false;
		}
	}
	return true;
}

int hashTable::nextPrime(unsigned int x){
	unsigned int next = x + 1;
	bool found = false;
	while(!found){
		if(isPrime(next)){
			found = true;
		}
		else{
			next++;
		}
	}
	return next;
}
void hashTable::insert(string input){
	(stack -> at(hash(input))).push_back(input);
}
bool hashTable::isFound(string input){
	list<string> &selection = stack -> at(hash(input));
	for(list<string>::iterator iter = selection.begin(); iter != selection.end(); iter++){
		if(input == *iter){
			return true;
		}
	}
	return false;
	
	
}
int hashTable::hash(string input){
	unsigned int next = 0;
	int size = (input.length() / 2) + 1;
	for(int i = 0; i<size; i+=2){
		next = (next * i) + input[i];
	}
	return next % hashTableSize;
}
