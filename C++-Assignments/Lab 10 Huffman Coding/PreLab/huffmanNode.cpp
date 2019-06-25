//Brian Barbu (brb9da)

#include "huffmanNode.h"

using namespace std;

huffmanNode::huffmanNode(int freq, char ch){
  left=NULL;
  right=NULL;
  f = freq;
  character = ch;
  prefix="";
}

huffmanNode::~huffmanNode(){
  delete left;
  delete right;
}

int huffmanNode::getF() const{
  return f;
}

char huffmanNode::getChar(){
  return character;
}

string huffmanNode::getPre(){
  return prefix;
}

bool huffmanNode::operator<(const huffmanNode& n) const{
  return((this -> getF()) < n.getF());
}

