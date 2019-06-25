# Austin Zavacky and Brian Barbu
# axz4jn and brb9da

import random

#Ask user to input their question
question = input("What question do you wish to ask the 8 ball? ")

#Creates a list of potential answers
answer_list = ["It is certain", "Signs point to yes", "Most likely", "Ask again later", "Cannot predict now",
               "Concentrate and ask again", "Don't count on it", "My reply is no", "My sources says no", "Very doubtful"]

#Randomly selects answer from list of answers
answer = answer_list[random.randint(0, len(answer_list)-1)]

print("You asked the 8 ball: ", question)
print("The 8 ball says: ", answer)