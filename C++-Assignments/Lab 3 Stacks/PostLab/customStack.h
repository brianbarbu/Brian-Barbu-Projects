//Brian Barbu (brb9da)
#ifndef STACK_H
#define STACK_H

#include <iostream>
#include "List.h"
#include "ListItr.h"
#include "ListNode.h"
using namespace std;

class customStack {
public:
    customStack();

    void push(int e);
    int top() const;
    void pop();
    bool empty() const;

private:
    List *thisStack;
    int count;
};

#endif
