//Brian Barbu (brb9da)
//bitfiddling problems

/*
thirdBits - return number with every third bit (starting from the LSB) set to 1
  Legal ops: ! ~ & ^ | + << >>
  Max ops: 8
  Rating: 1
*/
int thirdBits(){
	int x = 1;
	x = (x<<3) + 1;
	x = x + (x << 6);
	x = x + (x << 12);
	x = x + (x << 24);
	return x;
}


/*
bang - Compute !x without using !
  Examples: bang(3) = 0, bang(0) = 1
  Legal ops: ~ & ^ | + << >>
  Max ops: 12
  Rating: 4 
*/
int bang(int x) {
	return ((x >> 31) | ((~x + 1) >> 31)) + 1;
}


/*
isEqual - return 1 if x == y, and 0 otherwise 
  Examples: isEqual(5,5) = 1, isEqual(4,5) = 0
  Legal ops: ! ~ & ^ | + << >>
  Max ops: 5
  Rating: 2
*/
int isEqual(int x, int y) {
	return !(x^y);
}


