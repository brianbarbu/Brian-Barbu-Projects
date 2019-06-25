//Brian Barbu (brb9da)
#include "postfixCalculator.h"

postfixCalculator::postfixCalculator(){
	current = new customStack;
}
void postfixCalculator::pushNum(int x){
	current -> push(x);
}
void postfixCalculator::add(){
	int x = current -> top();
	current -> pop();
	int y = current -> top();
	current -> pop();
	current -> push(x+y);
}
void postfixCalculator::subtract(){
	int x = current -> top();
	current -> pop();
	int y = current -> top();
	current -> pop();
	current -> push(y-x);
}
void postfixCalculator::divide(){
	int x = current -> top();
	current -> pop();
	int y = current -> top();
	current -> pop();
	current -> push(y/x);
}
void postfixCalculator::multiply(){
	int x = current -> top();
	current -> pop();
	int y = current -> top();
	current -> pop();
	current -> push(x*y);
}
int postfixCalculator::topNum(){
	return current -> top();
}
void postfixCalculator::negate(){
	int x = current -> top();
	current -> pop();
	current -> push(x*-1);
}


