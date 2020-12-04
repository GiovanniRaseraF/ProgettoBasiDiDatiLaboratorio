import os
import sys

file1 = open('../Parata/CSV/dati_anagrafici_clienti.csv', 'r')
righe = file1.readlines()


print("INSERT INTO VALUES")
for riga in righe:
    info = riga.split(",")
    for i in range(0, len(info)):
        info[i] = info[i].replace('\'', "").replace('\"', "")
    print("(\'{}\',\'{}\',\'{}\',\'{}\',\'{}\'),".format(info[0],info[1],info[2],info[3],info[4].strip('\n')))

    