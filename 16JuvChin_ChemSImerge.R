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

#make sure there are no spaces in the ANYTHING
Chin16UWcn <- UWcn[UWcn$Project == "2016_Juvenile_Chinook",] #returns all columns of data for 2016 Juvenile Chinook

Chin16UWsulf <- UWsulf[UWsulf$Study == "2016_Juvenile_Chinook",]

#Merge CN and S data
SIs <- inner_join(Chin16UWcn, Chin16UWsulf, by = c("SampleID"))

#create dataframe of only the data needed to merge with POPs data
ChinSIs <- as.data.frame(SIs[c(1:59,67:157), c(3,4,8:21,28:34)]) 

#SAVE as standalone excel files jic
write.csv(ChinSIs, paste(outfile, "2016JuvenileChinook_UW_StableIsotopes.csv", sep = ""))


#THEN merge ALL datasets
alldat <- full_join(POPs, ChinSIs, by = c("SampleID"))
write.csv(alldat, paste(outfile, "2016JuvenileChinook_POpsAndSIs.csv", sep = ""))



#at end, subset out different studies from UW Carbon and Nitrogen data and merge with corresponding Sulfer data
