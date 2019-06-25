//Brian Barbu (brb9da)

#include "tree.h"

using namespace std;

tree::tree(){
  root = NULL;
}

tree::~tree(){
  delete root;
}

heap tree::createTree(heap current){
  while(current.getSize()>1){
  	huffmanNode* x = current.findMin();
  	current.deleteMin();

  	huffmanNode* y = current.findMin();
  	current.deleteMin();

  	huffmanNode* combo = combine(x, y);
  	current.insert(combo);
  }
  return current;
}

huffmanNode* tree::combine(huffmanNode* x, huffmanNode* y) {
  int xF = x -> getF();
  int yF = y -> getF();
  int total = xF + yF;
  huffmanNode* combo = new huffmanNode(total, '0');
  combo -> left = x;
  combo -> right = y;
  return combo;
}

void tree::set(huffmanNode *root, string ch){
  if(root -> left == NULL && root -> right == NULL){
    (root -> prefix) = ch;
  }
  if(root -> left){
    set(root -> left, ch + "0");
  }
  if(root -> right) {
    set(root -> right, ch + "1");
  }
}
    
void tree::print(huffmanNode *root, string ch){
  if(root -> left == NULL && root -> right == NULL){
    cout << root -> character << "  " << ch <<endl;
  }
  if(root->left){
    print(root->left, ch +"0");
  }
  if(root->right) {
    print(root->right, ch + "1");
  }
}
