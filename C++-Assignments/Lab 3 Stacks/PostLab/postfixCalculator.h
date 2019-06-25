//Brian Barbu (brb9da)
#ifndef POSTFIXCALCULATOR_H
#define POSTFIXCALCULATOR_H

#include "customStack.h"
using namespace std;

class postfixCalculator{

	public:
		postfixCalculator();
		void pushNum(int x);
		void add();
		void subtract();
		void divide();
		void multiply();
		int topNum();
		void negate();
	private:
		customStack *current;
};

#endif
