### MERGING ALL 2016 JUVENILE CHINOOK DATA WITH CORRESPONDING STABLE ISOTOPE DATA ###

#clear workspace
rm(list=ls(all=TRUE))

#load packages
library(readxl)

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
while(i <= length(colnames(NOAAsi))) {
  oldNM <- colnames(NOAAsi)[i]
  newNM <- paste("NOAA_",oldNM,sep="")
  colnames(NOAAsi)[i] <- newNM
  
  i = i + 1
}

