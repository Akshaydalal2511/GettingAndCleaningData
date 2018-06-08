setwd("C:/Users/Sanket/Desktop/Akshay/Coursera/Getting and Cleaning Data/Getting and Cleaning Data Course Project")
library(dplyr)
library(data.table)


## Loading the text files as table into variables
activityLabels <- read.table("./UCI HAR Dataset/activity_labels.txt")
features <- read.table("./UCI HAR Dataset/features.txt")

## Loading Test and Train data
trainFeaturesData <- read.table("./UCI HAR Dataset/train/X_train.txt")
trainSubjectID <- read.table("./UCI HAR Dataset/train/subject_train.txt")
trainActivityCode <- read.table("./UCI HAR Dataset/train/y_train.txt")
testFeaturesData <- read.table("./UCI HAR Dataset/test/X_test.txt")
testSubjectID <- read.table("./UCI HAR Dataset/test/subject_test.txt")
testActivityCode <- read.table("./UCI HAR Dataset/test/y_test.txt")

## Merging test and train Data individualy
featuresData <- rbind(trainFeaturesData,testFeaturesData)
subjectID <- rbind(trainSubjectID,testSubjectID)
activityCode <- rbind(trainActivityCode,testActivityCode)

## Extracting mean and std data from features
featuresNames <- features[,2]
usefulFeaturesNamesIndex <- grep("mean|std",featuresNames)
usefulFeaturesNames <- featuresNames[usefulFeaturesNamesIndex]

## Renaming usefulFeatures and activity labels
usefulFeaturesNames <- sub("^t","time",usefulFeaturesNames)
usefulFeaturesNames <- sub("^f","freq",usefulFeaturesNames)
usefulFeaturesNames <- sub("-m","M",usefulFeaturesNames)
usefulFeaturesNames <- sub("-s","S",usefulFeaturesNames)
usefulFeaturesNames <- sub("-","",usefulFeaturesNames)
activityLabels$V2 <- sub("_"," ",activityLabels$V2)

## Selecting std and mean data from featuresData
featuresData <- select(featuresData,usefulFeaturesNamesIndex)

## Renaming the columns of featuresData, SubjectID and Activity
colnames(featuresData) <- usefulFeaturesNames
colnames(subjectID) <- "SubjectID"
colnames(activityCode) <- "Activity"

## Merging the data
mergedData <- cbind(subjectID,activityCode,featuresData)

## Replacing the activity codes with their lables
mergedData <- mutate(mergedData,Activity = mapvalues(mergedData$Activity,activityLabels$V1,as.character(activityLabels$V2)))

## Summerizing the feature means on basis of SubjectID's and Activity
tidyData <- mergedData %>% group_by(SubjectID,Activity) %>%
  summarise_all(funs(mean))

View(tidyData)