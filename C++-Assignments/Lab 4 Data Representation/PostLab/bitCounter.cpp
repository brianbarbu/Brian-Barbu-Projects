//Brian Barbu (brb9da)

#include <iostream>
#include <cstdlib>

using namespace std;

int main(int argc, char *argv[]){

	while(1){
		if(argc == 0){
			cout << "Enter input greater than 0" << endl;
			break;
		}
		int entered = atoi(argv[1]);
		int count = 0;
		while(entered > 0){
			count += (entered % 2);
			entered = entered / 2;
		}
		cout << "Number of 1's in Binary Representation: " << count << endl;
		break;
	}
}