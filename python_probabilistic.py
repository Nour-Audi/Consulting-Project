# -*- coding: utf-8 -*-
"""
Created on Tue Apr 18 2017

@author: Hunter Tolbert
"""

import pandas as pd

# read in the 3 datasets
scsr = pd.read_csv("SCSR-2014.csv", sep="|", low_memory=False)
snhr = pd.read_csv("SNHR-2014.csv", sep="|", low_memory=False)
vdc = pd.read_csv("VDC-2014.csv", sep="|", low_memory=False)

# pull out the relevant information from the 3 datasets
scsr1 = pd.DataFrame({"fullname": scsr["name"] + scsr["surname"], "date": scsr["date_of_death"], "governorate": scsr["governorate"], "dtf": "scsr"})
snhr1 = pd.DataFrame({"fullname": snhr["fullname"], "date": snhr["date_of_death"], "governorate": snhr["governorate"], "dtf": "snhr"})
vdc1 = pd.DataFrame({"fullname": vdc["name"], "date": vdc["date_of_death"], "governorate": vdc["governorate"], "dtf": "vdc"})

# turn the data field into a Pandas datetime
scsr1["date"] = pd.to_datetime(scsr1["date"], format="%Y-%m-%d", errors="coerce")
snhr1["date"] = pd.to_datetime(snhr1["date"], format="%Y-%m-%d", errors="coerce")
vdc1["date"] = pd.to_datetime(vdc1["date"], format="%Y-%m-%d", errors="coerce")

# create one big dataframe with all three datasets and subset the appropriate time
dtf = pd.concat([scsr1, snhr1, vdc1])
dtf = dtf[dtf.date < pd.to_datetime("2011-09-15", format="%Y-%m-%d")]
dft = dtf[dtf.date > pd.to_datetime("2011-03-15", format="%Y-%m-%d")]

# initialize that none of the records are duplicates
dtf0.duplicate = False

# split the dataframe by governorate in order to work within each
dtf1 = dtf0[dtf0.governorate == "Al-Hasaka"]
dtf1.name = "dtf1"
dtf2 = dtf0[dtf0.governorate == "Aleppo"]
dtf2.name = "dtf2"
dtf3 = dtf0[dtf0.governorate == "Ar-Raqqah"]
dtf3.name = "dtf3"
dtf4 = dtf0[dtf0.governorate == "As-Suwayda"]
dtf4.name = "dtf4"
dtf5 = dtf0[dtf0.governorate == "Damascus"]
dtf5.name = "dtf5"
dtf6 = dtf0[dtf0.governorate == "Daraa"]
dtf6.name = "dtf6"
dtf7 = dtf0[dtf0.governorate == "Deir ez-Zor"]
dtf7.name = "dtf7"
dtf8 = dtf0[dtf0.governorate == "Egypt"]
dtf8.name = "dtf8"
dtf9 = dtf0[dtf0.governorate == "Germany"]
dtf9.name = "dtf9"
dtf10 = dtf0[dtf0.governorate == "Hama"]
dtf10.name = "dtf10"
dtf11 = dtf0[dtf0.governorate == "Homs"]
dtf11.name = "dtf11"
dtf12 = dtf0[dtf0.governorate == "Idlib"]
dtf12.name = "dtf12"
dtf13 = dtf0[dtf0.governorate == "Iraq"]
dtf13.name = "dtf13"
dtf14 = dtf0[dtf0.governorate == "Jordan"]
dtf14.name = "dtf14"
dtf15 = dtf0[dtf0.governorate == "Latakia"]
dtf15.name = "dtf15"
dtf16 = dtf0[dtf0.governorate == "Lebanon"]
dtf16.name = "dtf16"
dtf17 = dtf0[dtf0.governorate == "Other"]
dtf17.name = "dtf17"
dtf18 = dtf0[dtf0.governorate == "Palestine"]
dtf18.name = "dtf18"
dtf19 = dtf0[dtf0.governorate == "Quneitra"]
dtf19.name = "dtf19"
dtf20 = dtf0[dtf0.governorate == "Rural Damascus"]
dtf20.name = "dtf20"
dtf21 = dtf0[dtf0.governorate == "Saudi Arabia"]
dtf21.name = "dtf21"
dtf22 = dtf0[dtf0.governorate == "Tartus"]
dtf22.name = "dtf22"
dtf23 = dtf0[dtf0.governorate == "Turkey"]
dtf23.name = "dtf23"

# initialize the possible_pairs dataframe
possible_pairs = pd.DataFrame()

# set up the date range for which we're allowing the possible pairs to be in
date_range = pd.Timedelta("7 days")

# create a tuple of dataframes to loop through
dataframes = (dtf1,dtf2,dtf3,dtf4,dtf5,dtf6,dtf7,dtf8,dtf9,dtf10,dtf11,dtf12,dtf13,dtf14,dtf15,dtf16,dtf17,dtf18,dtf19,dtf20,dtf21,dtf22,dtf23)

# this loop adds to possible pairs all matches on exact governorate and date within a week
for dtf in dataframes:
    for ii in range(len(dtf.fullname)):
        for jj in range(len(dtf.fullname)):
            if ii < jj:
                if (dtf.iloc[jj].date - date_range) <= dtf.iloc[ii].date <= (dtf.iloc[jj].date - date_range):
                    possible_pairs = possible_pairs.append({"index1": ii, "index2": jj, "dtf": dtf.name}, ignore_index=True)

# define a function that returns whether or not two governorates are adjacent
def isAdjacent(gov1, gov2):
    if gov1.name == "dtf1":
        if gov2.name in ["dtf3", "dtf7"]:
            return True
    elif gov1.name == "dtf2":
        if gov2.name in ["dtf3", "dtf10", "dtf12"]:
            return True
    elif gov1.name == "dtf3":
        if gov2.name in ["dtf1", "dtf7", "dtf10", "dtf11"]:
            return True
    elif gov1.name == "dtf4":
        if gov2.name in ["dtf6", "dtf20"]:
            return True
    elif gov1.name == "dtf5":
        if gov2.name in ["dtf20"]:
            return True
    elif gov1.name == "dtf6":
        if gov2.name in ["dtf4", "dtf19", "dtf20"]:
            return True
    elif gov1.name == "dtf7":
        if gov2.name in ["dtf1", "dtf3", "dtf11"]:
            return True
    elif gov1.name == "dtf10":
        if gov2.name in ["dtf2", "dtf3", "dtf11", "dtf12", "dtf15", "dtf22"]:
            return True
    elif gov1.name == "dtf11":
        if gov2.name in ["dtf3", "dtf7", "dtf10", "dtf20", "dtf22"]:
            return True
    elif gov1.name == "dtf12":
        if gov2.name in ["dtf2", "dtf10", "dtf15"]:
            return True
    elif gov1.name == "dtf15":
        if gov2.name in ["dtf10", "dtf12", "dtf22"]:
            return True
    elif gov1.name == "dtf19":
        if gov2.name in ["dtf6", "dtf20"]:
            return True
    elif gov1.name == "dtf20":
        if gov2.name in ["dtf4", "dtf5", "dtf6", "dtf11", "dtf19"]:
            return True
    elif gov1.name == "dtf22":
        if gov2.name in ["dtf10", "dtf11", "dtf15"]:
            return True
    return False

# this loop adds to the possible pairs all matches on adjacent governorates and date within a week
for dtf_1 in dataframes:
    for dtf_2 in dataframes:
        if dtf_1.name != dtf_2.name and isAdjacent(dtf_1, dtf_2):
            for ii in range(len(dtf_1.fullname)):
                for jj in range(len(dtf_2.fullname)):
                    if (dtf_2.iloc[jj].date - date_range) <= dtf_1.iloc[ii].date <= (dtf_2.iloc[jj].date - date_range):
                        possible_pairs = possible_pairs.append({"index1": ii, "index2": jj, "dtf": (dtf_1.name, dtf_2.name)}, ignore_index=True)

# this loops adds to the possible pairs all matches on first 5 letters of name not including Muhammad
for dtf_1 in dataframes:
    for dtf_2 in dataframes:
        for index1, row1 in dtf_1.iterrows():
            for index2, row2 in dtf_2.iterrows():
                if row1.fullname[0:5] == row2.fullname[0:5] and row1.fullname[0:4] != "محمد":
                    possible_pairs = possible_pairs.append({"index1": ii, "index2": jj, "dtf": (dtf_1.name, dtf_2.name)}, ignore_index=True)

# define a function that computes the Jaro-Winkler distance on two strings
def compare_string(string1, string2):
    m = 0
    t = 0
    pre = 0
    for ii in range(len(string1) - 1):
        for jj in range(len(string2) - 1):
            if ii == jj:
                if string1[ii] == string2[jj]:
                    m += 1
                    t += 1
            elif ii < jj and abs(ii - jj) <= max(len(string1), len(string2)) / 2 - 1:
                if string1[ii] == string2[jj]:
                    m += 1
    for ii in range(min(len(string1), len(string2)) - 1):
        if string1[ii] == string2[ii]:
            pre += 1
    
    t = t / 2
    d = (1 / 3) * (m / len(string1) + m / len(string2) + (m - t) / m)
    dist = d + (.1 * pre * (1 - d))
    return dist

# initilize a count for how many duplicates we find and initialize a dataframe containing these duplicates
count = 0
duplicates = pd.DataFrame()         

# look within each dataframe and compare names in order to find duplicates   
for dtf in dataframes:
    for index, row in possible_pairs.iterrows():
        if row.dtf == dtf.name:
            s = compare_string(dtf.iloc[int(row.index1)].fullname, dtf.iloc[int(row.index2)].fullname)
            if s > .6:
                count += 1
                duplicates = duplicates.append(dtf.iloc[int(row.index1)])
                duplicates = duplicates.append(dtf.iloc[int(row.index2)])
                dtf.iloc[int(row.index1)].duplicate = True
                dtf.iloc[int(row.index2)].duplicate = True

# look between each dataframe and compare names in order to find duplicates
for dtf_1 in dataframes:
    for dtf_2 in dataframes:
        for index, row in possible_pairs.iterrows():
            if type(row.dtf) is tuple:
                if row.dtf[0] == dtf_1.name and row.dtf[1] == dtf_2.name:
                    s = compare_string(dtf_1.iloc[int(row.index1)].fullname, dtf_2.iloc[int(row.index2)].fullname)
                    if s > .6:
                        count += 1
                        duplicates = duplicates.append(dtf_1.iloc[int(row.index1)])
                        duplicates = duplicates.append(dtf_2.iloc[int(row.index2)])
                        dtf_1.iloc[int(row.index1)].duplicate = True
                        dtf_2.iloc[int(row.index2)].duplicate = True
                        
# unite all the dataframes that were previously separated by governorate                        
dataframes = (dtf1,dtf2,dtf3,dtf4,dtf5,dtf6,dtf7,dtf8,dtf9,dtf10,dtf11,dtf12,dtf13,dtf14,dtf15,dtf16,dtf17,dtf18,dtf19,dtf20,dtf21,dtf22,dtf23)
dtf0 = pd.concat(dataframes)

# output
print count
possible_pairs.to_csv(path_or_buf="/TOIL-U4/htolbert/raw2014/possible_pairs.csv")
duplicates.to_csv(path_or_buf="/TOIL-U4/htolbert/raw2014/duplicates.csv")
dtf0.to_csv(path_or_buf="/TOIL-U4/htolbert/raw2014/combined.csv")
