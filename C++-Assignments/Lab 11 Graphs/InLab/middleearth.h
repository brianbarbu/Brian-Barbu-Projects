//Brian Barbu (brb9da)

#include <iostream>
#include <vector>
#include <string>
#include <map>

#ifndef MIDDLEEARTH_H
#define MIDDLEEARTH_H

using namespace std;

// see the comments in the lab11 write-up, or in middleearth.cpp

class MiddleEarth {
private:
	//variables for calculating distance
    int num_city_names, xsize, ysize;
    vector<float> xpos, ypos;
	//hold cities
    vector<string> cities;
	//hold distances
    float *distances;
	//for calculating distance
    map<string, int> indices;

public:
    MiddleEarth (int xsize, int ysize, int numcities, int seed);
    ~MiddleEarth();
	//print methods
    void print();
    void printTable();
	//distance between two cities
    float getDistance (string city1, string city2);
    vector<string> getItinerary(unsigned int length);
};

#endif
