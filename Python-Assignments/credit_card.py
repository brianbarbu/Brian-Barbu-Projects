#Brian Barbu (brb9da)

#asks for number and saves input, then separates string

numbers = (input("Type a credit card number (just digits): "))
while numbers.isdigit()is not True:
    numbers = (input("Type a credit card number (just digits): "))

numbers.split()

#sets initial sum1 to zero
sum1 = 0
#sets count equal to the index of the last digit
count=len(numbers)-1

#loops for entire length of string and adds every other number starting from far right
while count > -1:
    add = int(numbers[count])
    sum1 = sum1 + add
    count-=2

#sets initial sum2 to zero
sum2=0
#sets count equal to index of second last digit
count2=len(numbers)-2

#loops for entire length of string and starts from second to last digit, adds every other together
while count2>-1:
    temp = int(numbers[count2])
    temp *= 2
    temp= str(temp)
    temp.split()
    add2=0
    for x in temp:
        add2+=int(x)

    #this number get doubled before being added
    sum2=sum2+ add2
    count2-=2

#total is the addition of both sums
total = sum1 + sum2

#turns total into string and separates it
total=str(total)
total.split()

#if the last digit is a zero, this number is a multiple of 10 and makes the credit card number valid
if int(total[len(total)-1]) == 0:
    print("Yes, "+numbers+" is a valid credit card number")
else:
    print(numbers + " is not a valid credit card number")