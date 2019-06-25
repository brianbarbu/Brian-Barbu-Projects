// Brian Barbu (brb9da)

// TreeCalc.cpp:  CS 2150 Tree Calculator method implementations

#include <cstdlib>
#include "TreeCalc.h"
#include <iostream>

using namespace std;

//Constructor
TreeCalc::TreeCalc() {
     stack<TreeNode*> mystack;
}

//Destructor- frees memory
TreeCalc::~TreeCalc() {
     mystack.empty();
}

//Deletes tree/frees memory
void TreeCalc::cleanTree(TreeNode* ptr) {
     cleanTree(ptr -> right);
     cleanTree(ptr -> left);
     delete ptr;
}

//Gets data from user
void TreeCalc::readInput() {
    string response;
    cout << "Enter elements one by one in postfix notation" << endl
         << "Any non-numeric or non-operator character,"
         << " e.g. #, will terminate input" << endl;
    cout << "Enter first element: ";
    cin >> response;
    //while input is legal
    while (isdigit(response[0]) || response[0]=='/' || response[0]=='*'
            || response[0]=='-' || response[0]=='+' ) {
        insert(response);
        cout << "Enter next element: ";
        cin >> response;
    }
}

//Puts value in tree stack
void TreeCalc::insert(const string& val) {
    // insert a value into the tree
    TreeNode *node = new TreeNode(val);
    if(isdigit(val[0]) || (isdigit(val[1]) && val[0] == '-')){
    	mystack.push(node);
    }
    else if(val[0] == '+' || val[0] == '-' || val[0] == '*' || val[0] == '/'){
    	TreeNode *rightbranch = mystack.top();
    	mystack.pop();
    	TreeNode *leftbranch = mystack.top();
    	mystack.pop();
    	node->right = rightbranch;
    	node->left = leftbranch;
    	mystack.push(node);
    } 
}

//Prints data in prefix form
void TreeCalc::printPrefix(TreeNode* ptr) const {
    // print the tree in prefix format
    if(ptr == NULL) {
   	return;
    }
    cout << ptr->value << " ";
   if(ptr->left != NULL) {
   	printPrefix(ptr->left);
   }
  
   if(ptr->right != NULL) {
        printPrefix(ptr->right);
   }
}

//Prints data in infix form
void TreeCalc::printInfix(TreeNode* ptr) const {
    // print tree in infix format with appropriate parentheses
     string current = ptr->value;
     if(ptr == NULL) {
    	return;
     }
    if(ptr->left != NULL) {
    	cout << "(";
    	printInfix(ptr->left);
    }
    if(isdigit(current[0]) || (current[0] == '-' && isdigit(current[1]))) {
    	cout << ptr->value;
    }
    else{
	 cout <<" " <<  ptr->value << " ";
    }
    if(ptr->right != NULL) {
	printInfix(ptr->right);
	cout << ")";
    }
}

//Prints data in postfix form
void TreeCalc::printPostfix(TreeNode* ptr) const {
    // print the tree in postfix form
    if(ptr == NULL) {
    	return;
    }
    if(ptr->left != NULL) {
    	printPostfix(ptr->left);
    }
    if(ptr->right != NULL) {
    	printPostfix(ptr->right);
    }
    cout << ptr->value << " ";
}

// Prints tree in all 3 (pre,in,post) forms

void TreeCalc::printOutput() const {
    if (mystack.size()!=0 && mystack.top()!=NULL) {
        cout << "Expression tree in postfix expression: ";
        // call your implementation of printPostfix()
	printPostfix(mystack.top());
        cout << endl;
        cout << "Expression tree in infix expression: ";
        // call your implementation of printInfix()
	printInfix(mystack.top());
        cout << endl;
        cout << "Expression tree in prefix expression: ";
        // call your implementation of printPrefix()
	printPrefix(mystack.top());
        cout << endl;
    } else
        cout<< "Size is 0." << endl;
}

//Evaluates tree, returns value
// private calculate() method
int TreeCalc::calculate(TreeNode* ptr) const {
    // Traverse the tree and calculates the result
     string current = ptr->value;
  if(current[0] == '+') {
    return (calculate(ptr->left) + calculate(ptr->right));
  }
  else if(current[0] == '-' && !isdigit(current[1])) {
    return (calculate(ptr->left) - calculate(ptr->right));
  }
  else if(current[0] == '*') {
    return (calculate(ptr->left) * calculate(ptr->right));
  }
  else if(current[0] == '/') {
    return (calculate(ptr->left) / calculate(ptr->right));
  }
  else{
	 return atoi(current.c_str());
  }
}

//Calls calculate, sets the stack back to a blank stack
// public calculate() method. Hides private data from user
int TreeCalc::calculate() {
    int i = 0;
    // call private calculate method here
    return calculate(mystack.top());
}
