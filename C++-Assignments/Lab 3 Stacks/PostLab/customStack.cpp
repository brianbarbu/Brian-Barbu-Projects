//Brian Barbu (brb9da)
#include <iostream>
#include "customStack.h"
using namespace std;
// constructor
customStack::customStack()
{
    thisStack = new List;
    count = 0;
}
void customStack::push(int e)
{
    thisStack -> insertAtTail(e);
}

void customStack::pop()
{
    ListItr mark = thisStack -> last();
    thisStack -> remove(mark.retrieve());
}

int customStack::top() const
{
    return thisStack -> last().retrieve();
}
bool customStack::empty() const
{
    if(count <1){
	return true;
    }
    else{
	return false;
    }
}
