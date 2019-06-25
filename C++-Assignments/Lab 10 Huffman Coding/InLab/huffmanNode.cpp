//Brian Barbu (brb9da)

#include <iostream>
#include "huffmanNode.h"
#include <string>

using namespace std;

huffmanNode::huffmanNode()
{
  	left = NULL;
  	right = NULL;
  	freq = 1;
  	character = '\0';
}
huffmanNode::huffmanNode(int f,char data)
{
  	left =NULL;
  	right =NULL;
  	character = data;
  	freq = f;
}

char huffmanNode::getChar()
{
  	return character;
}
bool huffmanNode::operator<(const huffmanNode& current) const{
  	return(this -> getF() < current.getF());
}
int huffmanNode::getF() const{
	return freq;
} 
