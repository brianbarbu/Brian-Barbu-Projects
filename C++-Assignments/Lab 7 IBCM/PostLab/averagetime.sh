#!/bin/bash
#Brian Barbu (brb9da)

while true
do
	count = 5
	total = 0
	
	echo "Input 'quit' to quit"
	echo "Enter the exponent."
	read input

	if [$input == "quit"]
	then
		exit 0
		fi
	
	for((i =0; i<=count;i++))
	do
		echo "Running iteration ${i}."
        	time= `./a.out ${input}`
        	total= `expr $total + $time`
        	echo "Time Taken: ${time} milliseconds"
	done
done

echo "Average Time: "`expr $total / $count`" ms"
