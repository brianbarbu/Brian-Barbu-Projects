//Brian Barbu (brb9da)
#ifndef HUFFMANNODE_H
#define HUFFMANNODE_H

#include <string>
#include <iostream>
using namespace std;

class huffmanNode {
 public:
  huffmanNode();
  huffmanNode(int freq, char ch);
  ~huffmanNode();
  huffmanNode *left, *right;

  int f;
  int getF()const;

  char character;
  char getChar();

  string prefix;
  string getPre();

  bool operator<(const huffmanNode& n) const;
};
#endif
