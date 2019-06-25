//Brian Barbu (brb9da)
#include <iostream>
#include <cstdlib>
#include <string>
#include "postfixCalculator.h"
using namespace std;

int main(){
	postfixCalculator p;
	while(true){
		string input;
		cin >> input;
		if(!cin.good()){
			break;
		}
		else if(input == "+"){
			p.add();
		}
		else if(input == "-"){
			p.subtract();
		}
		else if(input == "*"){
			p.multiply();
		}
		else if(input == "/"){
			p.divide();
		}
		else if(input == "~"){
			p.negate();
		}
		else{
			p.pushNum(atoi(input.c_str()));
		}
	}
	cout << "Result: " << p.topNum() << endl;
}
