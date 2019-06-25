#Brian Barbu (brb9da)

CXX = clang++
CXXFLAGS = -Wall -g -std=c++11
OFILES = AVLTree.o AVLNode.o AVLPathTest.o

.SUFFIXES: .o .cpp

main:	$(OFILES)
	$(CXX) $(OFILES)

clean:
	/bin/rm -f *.o *~

AVLTree.o: AVLTree.cpp AVLTree.h AVLNode.h
AVLNode.o: AVLNode.h AVLNode.cpp
BSTPathTest.o: AVLPathTest.cpp AVLTree.h AVLNode.h
