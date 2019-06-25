//Brian Barbu (brb9da)

#ifndef HEAP_H
#define HEAP_H

#include <vector>
#include <iostream>
#include "huffmanNode.h"

//implement huffmanNodes

using namespace std;

class heap{
 public:
  heap();
  ~heap();
   
  void insert(huffmanNode* n);
  int getSize();
  void makeEmpty();
  bool isEmpty();
  //change
   void deleteMin();
  huffmanNode* findMin();
  vector<huffmanNode*> getVector();

 private:
  vector<huffmanNode*> stack;
  int count;
};
#endif
