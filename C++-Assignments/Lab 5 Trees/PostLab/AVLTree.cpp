//Brian Barbu (brb9da)

#include <iostream>
#include "AVLTree.h"
#include <string>
#include "AVLNode.h"
using namespace std;

AVLTree::AVLTree() { root = NULL;
count = 0; }

AVLTree::~AVLTree() {
  delete root;
  root = NULL;
  count = 0;
}

// insert finds a position for x in the tree and places it there, rebalancing
// as necessary.
void AVLTree::insert(const string& x) {
  // YOUR IMPLEMENTATION GOES HERE
	insert(root, x);
}
AVLNode* AVLTree::insert(AVLNode *&select, const string& x){
	if( select == NULL){
		select = new AVLNode();
		select -> value = x;
		count++;
		return select;
	}
	else if(x < select ->value){
		 return insert(select -> left, x);
	}
	else if(select -> value < x){
		return insert(select -> right, x);
	}
	else{
		return NULL;
	}
	select->height = 1 + max(height(select->left), height(select->right));
  	balance(select);

}

// remove finds x's position in the tree and removes it, rebalancing as
// necessary.
void AVLTree::remove(const string& x) { root = remove(root, x);
count --; }

// pathTo finds x in the tree and returns a string representing the path it
// took to get there.
string AVLTree::pathTo(const string& x) const {
  // YOUR IMPLEMENTATION GOES HERE
	if(find(x) == false){
		return "";
	}
	else{
		return map(this -> root, x);
	}
}

string AVLTree::map(AVLNode *select, const string& x) const {
	if(find(x) == false){
		return "";
	}
	if(select == NULL){
		return "";
	}
	else if(select -> value == x){
		return " " + (select ->value);
	}
	else if(select -> value < x){
		return " " + (select ->value) + map(select -> right, x);
	}
	else if(select -> value > x){
		return " " + (select ->value) + map(select -> left, x);
	}
	else{
		return "";
	}
}

// find determines whether or not x exists in the tree.
bool AVLTree::find(const string& x) const {
  // YOUR IMPLEMENTATION GOES HERE
	return deepfind(root, x);
	
}
bool AVLTree::deepfind(AVLNode *select, const string& x) const{
	if(select == NULL){
		return false;
	}
	else if(select -> value == x){
		return true;
	}
	else if(select -> value < x){
		return deepfind(select -> right, x);
	}
	else if(select -> value > x){
		return deepfind(select -> left, x);
	}
}

// numNodes returns the total number of nodes in the tree.
int AVLTree::numNodes() const {
  // YOUR IMPLEMENTATION GOES HERE
	return count;
}

// balance makes sure that the subtree with root n maintains the AVL tree
// property, namely that the balance factor of n is either -1, 0, or 1.
void AVLTree::balance(AVLNode*& n) {
  // YOUR IMPLEMENTATION GOES HERE
	if((height(n -> right) - height(n->left)) == 2){
		if((height((n->right)->right) - height((n->right)->left)) == 1){
			//single right rotate
			rotateRight(n);
		}
		else{
			//double right rotate
			rotateLeft(n->right);
			rotateRight(n);
		}
	}
	else if((height(n->left) - height(n->right)) == -2){
		if(height((n->left)->left)-height((n->left)->right) == 1){
			//single left rotate
			rotateLeft(n);
		}
		else{
			//double left rotate
			rotateRight(n -> left);
			rotateLeft(n);
		}
	}
}

// rotateLeft performs a single rotation on node n with its right child.
AVLNode* AVLTree::rotateLeft(AVLNode*& n) {
  // YOUR IMPLEMENTATION GOES HERE
	AVLNode* m = n -> left;
	n -> left = m -> right;
	m -> right = n;
	n -> height = max( height( n -> left), height(n -> right)) + 1;
	m -> height = max( height( m -> left), n -> height) + 1;
	n = m;
	return m;
}

// rotateRight performs a single rotation on node n with its left child.
AVLNode* AVLTree::rotateRight(AVLNode*& n) {
  // YOUR IMPLEMENTATION GOES HERE
	AVLNode* m = n -> right;
	n -> right = m -> left;
	m -> left = n;
	n -> height = max( height( n -> left), height(n -> right)) + 1;
	m -> height = max( height( m -> right), n -> height) + 1;
	n = m;
	return m;
}

// private helper for remove to allow recursion over different nodes. returns
// an AVLNode* that is assigned to the original node.
AVLNode* AVLTree::remove(AVLNode*& n, const string& x) {
  if (n == NULL) {
    return NULL;
  }
  // first look for x
  if (x == n->value) {
    // found
    // no children
    if (n->left == NULL && n->right == NULL) {
      delete n;
      n = NULL;
      return NULL;
    }
    // single child
    if (n->left == NULL) {
      AVLNode* temp = n->right;
      n->right = NULL;
      delete n;
      n = NULL;
      return temp;
    }
    if (n->right == NULL) {
      AVLNode* temp = n->left;
      n->left = NULL;
      delete n;
      n = NULL;
      return temp;
    }
    // two children -- tree may become unbalanced after deleting n
    string sr = min(n->right);
    n->value = sr;
    n->right = remove(n->right, sr);
  } else if (x < n->value) {
    n->left = remove(n->left, x);
  } else {
    n->right = remove(n->right, x);
  }
  n->height = 1 + max(height(n->left), height(n->right));
  balance(n);
  return n;
}

// min finds the string with the smallest value in a subtree.
string AVLTree::min(AVLNode* node) const {
  // go to bottom-left node
  if (node->left == NULL) {
    return node->value;
  }
  return min(node->left);
}

// height returns the value of the height field in a node. If the node is
// null, it returns -1.
int AVLTree::height(AVLNode* node) const {
  if (node == NULL) {
    return -1;
  }
  return node->height;
}

// max returns the greater of two integers.
int max(int a, int b) {
  if (a > b) {
    return a;
  }
  return b;
}

// Helper function to print branches of the binary tree
void showTrunks(Trunk* p) {
  if (p == nullptr) return;
  showTrunks(p->prev);
  cout << p->str;
}

// Recursive function to print binary tree
// It uses inorder traversal
void AVLTree::printTree(AVLNode* root, Trunk* prev, bool isLeft) {
  if (root == NULL) return;

  string prev_str = "    ";
  Trunk* trunk = new Trunk(prev, prev_str);

  printTree(root->left, trunk, true);

  if (!prev)
    trunk->str = "---";
  else if (isLeft) {
    trunk->str = ".---";
    prev_str = "   |";
  } else {
    trunk->str = "`---";
    prev->str = prev_str;
  }

  showTrunks(trunk);
  cout << root->value << endl;

  if (prev) prev->str = prev_str;
  trunk->str = "   |";

  printTree(root->right, trunk, false);
}

void AVLTree::printTree() { printTree(root, NULL, false); }
