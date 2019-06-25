# Brian Barbu (brb9da)

def hangman_encrypted(w):
    word = ""
    for char in w:
        word += "-"
    return word


def hangman_guesses(w):
    guesses = 6
    result = True
    (encrypted) = hangman_encrypted(user_input)
    decrypted = list(encrypted)
    answer = list(user_input)
    while result:
        if guesses == 0:
            print('You lose! The word was "%s"' % ("".join(user_input)))
            result = False
        elif decrypted == answer:
            print('You win! The word was "%s"' % ("".join(user_input)))
            result = False
        else:
            letter_guess = input("[%s] You have %d left, enter a letter:" % ("".join(decrypted), guesses)).upper()
            if letter_guess in user_input:
                print("Correct!")
            elif letter_guess not in user_input:
                guesses -= 1
                print("Incorrect!")
            for i in range(0, len(user_input)):
                if letter_guess == user_input[i]:
                    decrypted[i] = letter_guess


user_input = input("Enter a word: ").upper()
hangman_guesses(user_input)
