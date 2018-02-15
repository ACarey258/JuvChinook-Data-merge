### MERGING ALL 2016 JUVENILE CHINOOK DATA WITH CORRESPONDING STABLE ISOTOPE DATA ###

#clear workspace
rm(list=ls(all=TRUE))

#load packages
library(readxl)
library(dplyr)

#set paths, make a list of text for the files to be used
paths = list("C:\\data\\CareyA\\PSEMP\\GitHub\\JuvChinook-2016\\JuvChinook-Data-merge\\2016JuvChinook _POPsData.xlsx",
             "C:\\data\\CareyA\\PSEMP\\GitHub\\JuvChinook-2016\\JuvChinook-Data-merge\\PS16JuvChinookWBSI.xlsx",
             "C:\\data\\CareyA\\PSEMP\\GitHub\\JuvChinook-2016\\JuvChinook-Data-merge\\UW_CN SI data_AllSpecies.xlsx",
             "C:\\data\\CareyA\\PSEMP\\GitHub\\JuvChinook-2016\\JuvChinook-Data-merge\\UW_Sulfur SI data_AllSpecies.xlsx",
             "C:\\data\\CareyA\\PSEMP\\GitHub\\JuvChinook-2016\\JuvChinook-Data-merge\\Outputs\\")

#set outfile
outfile = paths[[5]]

POPs <- read_excel(paths[[1]], "JuvChinPOPs2016")
NOAAsi <- read_excel(paths[[2]], "PS16JuvChinookSI")
UWcn <- read_excel(paths[[3]], "CNdata")
UWsulf <- read_excel(paths[[4]], "SulfurData_ALL")

#add NOAA_ as a prefix to all column names in NOAAsi dataframe
i = 1
while(i <= length(colnames(NOAAsi))) {
  oldNM <- colnames(NOAAsi)[i]
  newNM <- paste("NOAA_",oldNM,sep="")
  colnames(NOAAsi)[i] <- newNM
  i = i + 1
}

colnames(NOAAsi)
names(NOAAsi)[names(NOAAsi) == 'NOAA_SampleID'] <- 'SampleID'

#subset 2016 Chinook data from UW CN and Sulfur datasets
colnames(UWcn)
UWcn[ ,c(4,1:3,5:21)]

Chin16UWcn <- subset(UWcn, Project == "2016 Juvenile Chinook") #returns columns but no rows


#colnames(UWsulf)
#UWsulf[ ,c(5,1:4,6:14)]

#at end subset out different studies from UW Carbon and Nitrogen data and merge with corresponding Sulfer data
