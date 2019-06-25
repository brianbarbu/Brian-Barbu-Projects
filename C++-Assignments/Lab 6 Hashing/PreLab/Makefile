#Brian Barbu (brb9da)

CXX = clang++
CXXFLAGS = -Wall -O2 -g -std=c++11
OFILES = hashTable.o wordPuzzle.o timer.o

.SUFFIXES: .o .cpp

main:	$(OFILES)
	$(CXX) $(OFILES)

clean:
	~rm *.o

hashTable.o: hashTable.h hashTable.cpp
wordPuzzle.o: wordPuzzle.cpp
timer.o: timer.cpp timer.h
