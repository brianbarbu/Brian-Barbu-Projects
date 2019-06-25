#Brian Barbu (brb9da)

# This Makefile shows how to link assembly with C/C++

# Defines the C++ compiler we'll be using
CXX	= clang -m64

# Defines the flags we'll be passing to the C++ compiler
CXXFLAGS	= -Wall -g

# All of the .o files for our program
OFILES	= linkedlist.c

# How to compile our final program.  Note that we do NOT specify an
# output executable name -- in order for this to work with the grading
# system, the file needs to be a.out (a.exe in Cygwin).
main:	$(OFILES)
	$(CXX) $(CXXFLAGS) $(OFILES)

# This will clean up (remove) all our object files.  The -f option
# tells rm to forcily remove the files (i.e. don't ask if they should
# be removed or not).  This removes object files (*.o) and Emacs
# backup files (*~)
clean:
	/bin/rm -f *.o *~

# We don't have any dependencies for this small program
