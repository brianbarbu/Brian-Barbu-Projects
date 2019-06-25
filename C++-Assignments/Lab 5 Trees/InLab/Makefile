#Brian Barbu (brb9da)

CXX = clang++
CXXFLAGS = -Wall -g -std=c++11
OFILES = BinarySearchTree.o BinaryNode.o BSTPathTest.o

.SUFFIXES: .o .cpp

main:	$(OFILES)
	$(CXX) $(OFILES)

clean:
	/bin/rm -f *.o *~

BinarySearchTree.o: BinarySearchTree.cpp BinarySearchTree.h BinaryNode.h
BinaryNode.o: BinaryNode.h BinaryNode.cpp
BSTPathTest.o: BSTPathTest.cpp BinarySearchTree.h BinaryNode.h
