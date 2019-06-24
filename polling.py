#Brian Barbu (brb9da)

import urllib.request

def load_state_polls(state):
    stringState = "http://elections.huffingtonpost.com/pollster/api/charts/2016-" + state + "-president-trump-vs-clinton.csv"
    stream = urllib.request.urlopen(stringState)

    decodeList=[]
    for line in stream:
        decoded = line.decode("UTF-8")
        decode = decoded.strip()
        decode = decode.split(",")
        decodeList.append(decode)
    decodeList.pop(0)
    return decodeList

def polls_average(state, completed_after, completed_before):
    decodeList = load_state_polls(state)
    trumpTotal = 0
    clintonTotal = 0
    totalCount = 0
    for x in decodeList:
        y = decodeList[decodeList.index(x)]
        if y[7] >= completed_after and y[7] <= completed_before:
            tempT = "%.2f" % float(y[0])
            tempC = "%.2f" % float(y[1])
            trumpTotal+= float(tempT)
            clintonTotal+= float(tempC)
            totalCount+=1
    trumpAverage = "%.2f" % (trumpTotal / totalCount)
    clintonAverage = "%.2f" % (clintonTotal / totalCount)
    totalList=[trumpAverage,clintonAverage]
    return totalList

def current_winner(poll):
    margin = 0
    if len(poll)==2:
        trumpPercent = float(poll[0])
        clintonPercent = float(poll[1])
        if trumpPercent > clintonPercent:
            margin = int(trumpPercent - clintonPercent)
            winner = "Trump"
        if clintonPercent> trumpPercent:
            margin = int(clintonPercent - trumpPercent)
            winner = "Clinton"
    if margin == 0:
        return "Tie"
    else:
        return winner + " +" + str(margin)