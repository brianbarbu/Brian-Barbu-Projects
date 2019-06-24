# Brian Barbu (brb9da)

import urllib.request
import re

#[a-zA-Z0-9_\.-]+@[a-zA-Z0-9_\.-]+[\.][a-zA-Z0-9_-]{2,}
def regex_1(url):
    stream = urllib.request.urlopen(url)
    regex = re.compile(r"[a-zA-Z0-9_\.-]+@[a-zA-Z0-9_\.-]+")
    emails = []
    for line in stream:
        decoded = line.decode("UTF-8").strip()
        stripDecoded = regex.findall(decoded)

        for x in stripDecoded:
            if x not in emails:
                x = re.sub(r'NOSPAM',"",x)
                if x[-1] == ".":
                    x = x[ : -1]
                    emails.append(x)
                elif "_" in x:
                    if x[1] == "_":
                        fixWord = x.replace("_","n")
                        emails.append(fixWord)
                    elif x[3]=="_":
                        fixWord = x.replace("_","e")
                        emails.append(fixWord)
                elif "." in x:
                    (reverse_first , reverse_second) = x.split("@")
                    reverse_decode = reverse_first.split(".")
                    first = reverse_decode[0]
                    if first.isalpha() and "." not in reverse_second:
                        reverseFound = x[ :: -1]
                        emails.append(reverseFound)
                    else:
                        emails.append(x)

                else:
                    emails.append(x)

        for y in emails:
            (first, last) = y.split("@")
            if y[-2] == ".":
                emails.remove(y)
            elif "." not in last:
                emails.remove(y)
            elif "." in last:
                divided = last.split(".")
                end = divided[-1]
                for w in end:
                    if w.isdigit():
                        emails.remove(y)
    return emails

def regex_2(url):
    stream = urllib.request.urlopen(url)
    regex = re.compile(r"[a-zA-Z]+[a-zA-Z-0-9\.-]+[dot]?[a-zA-Z0-9_\.-]+[(| |]+[at]+[)| |]+[a-zA-Z0-9_\.-]+[\.dot| |]+[a-zA-Z]+")
    emails2 = []
    editedEmails = []
    for line in stream:
        decoded = line.decode("UTF-8").strip()
        stripDecoded = regex.findall(decoded)

        for x in stripDecoded:
            if x not in emails2:
                emails2.append(x)
        for y in emails2:
            a = y.replace(" dot ", ".")
            b = a.replace(" at ", "@")
            c = b.replace(" ", "")

            if "." in c:
                if c not in editedEmails:
                    editedEmails.append(c)
    return editedEmails



def find_emails_in_website(url):
    emails = regex_1(url)
    editedEmails = regex_2(url)
    allEmails = emails + editedEmails
    no_repeats = []
    for x in allEmails:
        if x not in no_repeats:
            no_repeats.append(x)
    return no_repeats

