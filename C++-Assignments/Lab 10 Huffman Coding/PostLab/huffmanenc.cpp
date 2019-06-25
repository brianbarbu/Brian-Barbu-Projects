//Brian Barbu (brb9da)

#include <stdio.h>
#include <stdlib.h>
#include <iostream>
#include "huffmanNode.h"
#include "heap.h"
#include "tree.h"

using namespace std;


int main (int argc, char **argv) {
    if ( argc != 2 ) {
        cout << "Enter input file name as the only parameter" << endl;
        exit(1);
    }

    FILE *read = fopen(argv[1], "r");
    if (read == NULL) {
        cout << "The file '" << argv[1] << "' does not exist in the directory!" << endl;
        exit(2);
    }

    int value[128];
    for(int i = 0; i < 128; i++){
      value[i] = 0;
    } 

    tree* groot;
    heap stack;

    int count = 0;
    int heapCount = 0;

    int ascii;
    char ch;
    
    while ((ch = fgetc(read)) != EOF ){
      ascii = (int) ch;
      if((ascii < 128) && (ascii > 31)){
	value[ascii]++;
	count++;
      }
    }
    
    for(int i = 1; i < 128; i++){
      if(value[i] > 0){
	huffmanNode* n = new huffmanNode(value[i], (char) i);
	stack.insert(n);
	heapCount++;
       }
    }

    groot = new tree();
    heap previous = groot -> createTree(stack);
    groot -> print(previous.findMin(), "");
    
    cout << "----------------------------------------" << endl;

    groot -> set(previous.findMin(),"");

    rewind(read);

    int comp = 0;
    int uncomp = 0;

    vector<huffmanNode*> huffVect = stack.getVector();
   
    while ((ch = fgetc(read)) != EOF ){
      for(int i = 1; i < stack.getSize() + 1; i++){
          if((huffVect[i] -> getChar()) == ch){
	    comp += (huffVect[i] -> getPre().size());
            cout << huffVect[i] -> getPre() << " ";
	  }
      }
    }
    cout << endl;

    fclose(read);
    cout << "----------------------------------------" << endl;

     uncomp = count * 8;
     double ratio = (double) uncomp / comp;
     double cost = (double) comp / count;

     cout << "Compression ratio: " << ratio << "." << endl;
     cout << "The Huffman Tree cost: " << cost << " bits per character" << endl;

    return 0;
}
