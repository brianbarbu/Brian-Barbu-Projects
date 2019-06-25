#Brian Barbu (brb9da)

CXX	= clang++

CXXFLAGS	= -Wall -g

OFILES	=  huffmanenc.o huffmanNode.o heap.o tree.o 

.SUFFIXES: .o .cpp

main:	$(OFILES)
	$(CXX) $(OFILES)

heap.o: heap.cpp heap.h huffmanNode.h
huffManNode.o: huffmanNode.cpp huffmanNode.h
tree.o: tree.cpp tree.h huffmanNode.h heap.h
huffManEnc.o: huffmanenc.cpp huffmanNode.h tree.h heap.h

clean:
	-rm -f *.o *~ a.out
