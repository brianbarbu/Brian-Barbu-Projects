//Brian Barbu (brb9da)

#include <iostream>
#include <fstream>
#include <sstream>
#include <stdlib.h>
#include <vector>
#include "huffmanNode.h"
using namespace std;

char move(huffmanNode* node, char bit);
void position(huffmanNode* node,string value,char c);




// main(): we want to use parameters
int main (int argc, char **argv) {

    huffmanNode* root = new huffmanNode();

    // verify the correct number of parameters
    if ( argc != 2 ) {
        cout << "Must supply the input file name as the only parameter" << endl;
        exit(1);
    }
    // attempt to open the supplied file; must be opened in binary
    // mode, as otherwise whitespace is discarded
    ifstream file(argv[1], ifstream::binary);
    // report any problems opening the file and then exit
    if ( !file.is_open() ) {
        cout << "Unable to open file '" << argv[1] << "'." << endl;
        exit(2);
    }
    
    
    // read in the first section of the file: the prefix codes
    while ( true ) {
        string character, prefix;
        // read in the first token on the line
        file >> character;
        // did we hit the separator?
        if ( (character[0] == '-') && (character.length() > 1) )
            break;
        // check for space
        if ( character == "space" )
            character = " ";
        // read in the prefix code
        file >> prefix;
        // do something with the prefix code
        cout << "character '" << character << "' has prefix code '"
             << prefix << "'" << endl;

	//added
	position(root,prefix,character[0]);
    }


    // read in the second section of the file: the encoded message
    stringstream sstm;
    while ( true ) {
        string bits;
        // read in the next set of 1's and 0's
        file >> bits;
        // check for the separator
        if ( bits[0] == '-' )
            break;
        // add it to the stringstream
        sstm << bits;
    }
    string allbits = sstm.str();
    // at this point, all the bits are in the 'allbits' string
    cout << "All the bits: " << allbits << endl;
   // close the file before exiting
    file.close();



    //decode
    huffmanNode *place = root;
    string decoded="";
    for(int i = 0; i < allbits.length(); i++){
	if(allbits.at(i) == '1')
	  place = place -> right;
	else if(allbits.at(i) == '0')
	  place = place -> left;
	if(move(place, allbits[i]) != '\0'){
	  decoded += move(place, allbits[i]);
	  place = root;
        }
    }
    cout<<"--------------------------------------"<<endl;
    cout<< decoded << endl;
}

//helpers

void position(huffmanNode* node, string value, char data)
{
	//placeholder
    int x = 0;
    if(value.at(x) == '1'){
      if(x == value.length() - 1){
	 huffmanNode *current = new huffmanNode(1, data);
	 node -> right = current;
      }
      else{
	if(node -> right==NULL){
	   huffmanNode *current = new huffmanNode();
	   node -> right = current;
	}
	value = value.substr(1, value.length());
	position(node -> right, value, data);
      }
    }
    else if(value.at(x) == '0'){
      if(x == value.length() - 1){
         huffmanNode *current = new huffmanNode(1, data);
	 node -> left = current;
      }
      else{
	if(node -> left == NULL){
            huffmanNode *current = new huffmanNode();
            node -> left = current;
        }
	value = value.substr(1, value.length());
        position(node -> left, value, data);
      }
    }
}

char move(huffmanNode* node, char bit)
{
  if(bit == '1'){
  	if(node -> right == NULL){
    		return node -> getChar();
	}
  	else{
    		return '\0';
	}
  }
  else{
  	if(node -> left == NULL){
    		return node -> getChar();
  	}
  	else{
    		return '\0';
  	}
  }
}
