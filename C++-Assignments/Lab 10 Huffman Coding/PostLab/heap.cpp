//Brian Barbu (brb9da)


#include "heap.h"

using namespace std;

heap::heap()
  :stack(100), count(0){
  }

heap::~heap(){
  makeEmpty();
}

void heap::insert(huffmanNode* n){
  int place = ++count;
  if(count == stack.size() - 1) {
    stack.resize(stack.size() * 2);
  }

  for(; (place > 1) && (*n<*stack[place / 2]); place /= 2) {
    stack[place] = stack[place / 2];
  }
  stack[place] = n;
}

//from percolate
void heap::deleteMin(){
  if(isEmpty()) {
    throw "deleteMin() called on empty heap"; 
  }
  stack[1] = stack[count--];
  int place = 1;
  huffmanNode* n = stack[place];
  int child;
  // while there is a left child...
  while(place * 2 <= count) {
    child = place * 2; //the left child
    // is there a right child? if so, is it lesser?
    if((child != count) && (*(stack[child+1])) < (*(stack[child]))) {
      child++;
    }
    // if the child is greater than the node...
    if((*stack[child]) < (*n)) {
      stack[place] = stack[child]; // move child up
      place = child;			// move place down
    }
    else 
      break;   
  }
  // correct position found! insert at that spot
  stack[place] = n;
}
    
huffmanNode* heap::findMin(){
  return stack[1];
}

int heap::getSize(){
  return count;
}

void heap::makeEmpty() {
  count = 0;
  stack.clear();
}

bool heap::isEmpty() {
  if(count == 0) {
    return true;
  }
  else{
	 return false;
  }
}

vector<huffmanNode*> heap::getVector(){
  return stack;
}
