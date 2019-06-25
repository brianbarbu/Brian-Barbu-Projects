//Brian Barbu (brb9da)

#include <iostream>
#include <stdio.h>
#include <stdlib.h>
#include <algorithm>

using namespace std;

#include "middleearth.h"

float computeDistance (MiddleEarth &me, string start, vector<string> dests);
void printRoute (string start, vector<string> dests);

int main (int argc, char **argv) {
    // check the number of parameters
    if ( argc != 6 ) {
        cout << "Usage: " << argv[0] << " <world_height> <world_width> "
             << "<num_cities> <random_seed> <cities_to_visit>" << endl;
        exit(0);
    }
    // we'll assume the parameters are all well-formed
    int width, height, num_cities, rand_seed, cities_to_visit;
    sscanf (argv[1], "%d", &width);
    sscanf (argv[2], "%d", &height);
    sscanf (argv[3], "%d", &num_cities);
    sscanf (argv[4], "%d", &rand_seed);
    sscanf (argv[5], "%d", &cities_to_visit);
    // Create the world, and select your itinerary
    MiddleEarth me(width, height, num_cities, rand_seed);
    vector<string> dests = me.getItinerary(cities_to_visit);
   

//store min path in path
    vector<string> path = dests;
    string first = dests[0];
    float check = 0.0;
    float min = computeDistance(me, first, dests);
    
    //sort before permutate
    sort(dests.begin() + 1, dests.end());
    while(next_permutation(dests.begin() + 1, dests.end())) {
    	check = computeDistance(me, first, dests);
    	if(check < min) {
		path = dests;
		min = check;
    	}
    }
    
    //print path and length
    cout << "Your journey will take you along the path ";
    printRoute(path[0], path); 
	cout << "\nand will have length " << min;
    cout << endl;
	
    return 0;
}

// This method will compute the full distance of the cycle that starts
// at the 'start' parameter, goes to each of the cities in the dests
// vector IN ORDER, and ends back at the 'start' parameter.
float computeDistance (MiddleEarth &me, string start, vector<string> dests) {
    // YOUR CODE HERE
	float total = 0.0;
	int length = dests.size();
	for(int i = 0; i < length; i++){
		total += me.getDistance(start, dests[i]);
		start = dests[i];
	}
	total += me.getDistance(dests[0], dests[length - 1]);

	return total;
}

// This method will print the entire route, starting and ending at the
// 'start' parameter.  The output should be of the form:
// Erebor -> Khazad-dum -> Michel Delving -> Bree -> Cirith Ungol -> Erebor
void printRoute (string start, vector<string> dests) {
    // YOUR CODE HERE
	vector<string>::iterator current;
	for(current = dests.begin(); current != dests.end(); current++){
		cout << *current << " -> ";
	}
	cout << start;
}

