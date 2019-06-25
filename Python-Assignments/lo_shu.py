# Austin Zavacky axz4jn
# Brian Barbu brb9da

numbers = (input("Numbers: ")).split()

#must enter 9 numbers for a lo shu sequence test without error
square = [[numbers[0], numbers[1], numbers[2]],[numbers[3],numbers[4], numbers[5]],[numbers[6],numbers[7],numbers[8]]]
count = 0

row_to_print = ""

print("You entered: ")
for row in square:
   for col in row:
       row_to_print += str(col) + "\t"
   print(row_to_print)
   row_to_print = ""

row_values = [[0,0,0],[0,0,0],[0,0,0]]
count = 0
for row in range(3):
    for col in range(3):
        row_values[row][col] = int(numbers[count])
        count +=1

col_values = [[0,0,0],[0,0,0],[0,0,0]]
count = 0
for col in range(3):
    for row in range(3):
        col_values[row][col] = int(numbers[count])
        count +=1

row1=row_values[0]
row2=row_values[1]
row3=row_values[2]

diag1 = [row1[0],row2[1],row3[2]]
diag2 = [row1[2],row2[1],row3[0]]


failcount=0
count=0
while count < 3:
    if sum(row_values[count]) != 15:
        print(row_values[count],"fails the test!")
        failcount+=1
    count+=1

count=0
while count < 3:
    if sum(col_values[count]) != 15:
        print("Column",count,"fails the test!")
        failcount+=1
    count+=1

if sum(diag1) != 15:
        print("Diagonal 1 fails the test!")
        failcount+=1

if sum(diag2) != 15:
        print("Diagonal 2 fails the test!")
        failcount+=1

if failcount != 0:
    print("This is not a Lo Shu Magic Square!")

if failcount==0:
    print("This is a valid Lo Shu Magic Square!")