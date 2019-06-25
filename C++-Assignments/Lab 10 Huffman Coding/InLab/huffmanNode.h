//Brian Barbu (brb9da)

#ifndef HUFFMAN_NODE_H
#define HUFFMAN_NODE_H

#include <vector>

using namespace std;

class huffmanNode {
	public:
    		huffmanNode();
    		huffmanNode(int f,char data);
    		huffmanNode *left, *right;
    		bool operator<(const huffmanNode& current) const;
    		char getChar();
		int getF() const;
	private:
    		char character;
    		int freq;
};
#endif
