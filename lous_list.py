#Brian Barbu (brb9da)

import urllib.request
def decodeit(department):
    listoflists = []
    url = "http://stardock.cs.virginia.edu/louslist/Courses/view/" + department
    stream = urllib.request.urlopen(url)
    for line in stream:
        decode = line.decode("UTF-8").strip()
        list = decode.split(";")
        listoflists.append(list)
    return listoflists

def instructors(department):
    listoflists= decodeit(department)
    professors = []
    for line in listoflists:
        teacher = line[4]
        if teacher not in professors:
            professors.append(teacher)
    professors.sort()
    return professors

def class_search(dept_name,has_seats_available=True, level=None, not_before=None,not_after =None):
    listoflists = decodeit(dept_name)
    finalList = []
    for line in listoflists:
        qualified= True
        if has_seats_available:
            if line[15] >= line[16]:
                qualified = False
        lineLevel = line[1]
        firstDigit=lineLevel[:1]

        if level != None:
            tlevel = str(level)
            firstTDigit = tlevel[:1]
            if firstDigit != firstTDigit:
                qualified = False
        lineStart = int(line[12])
        #if has_seats_available and lineStart == -1:
        #    qualified= False
        if not_before != None:
            if lineStart < not_before:
                qualified = False
        if not_after != None:
            if lineStart > not_after:
                qualified = False
        if qualified == True:
            finalList.append(line)
    return finalList


