//Brian Barbu (brb9da)

#ifndef TREE_H
#define TREE_H

#include "huffmanNode.h"
#include "heap.h"

using namespace std;

class tree{
 public:
  tree();
  ~tree();
  heap createTree(heap current);
  huffmanNode *root;
  huffmanNode *combine(huffmanNode *x, huffmanNode *y);
  void set(huffmanNode *root, string ch);
  void print(huffmanNode *root, string ch);
};
#endif
