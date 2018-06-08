# Code Book for [run_analysis.R](https://github.com/Akshaydalal2511/GettingAndCleaningData/blob/master/run_analysis.R)

## Data:
- activityLabels <- stores data frame from activity_labels.txt
- features <- stores data frame from features.txt
- trainFeaturesData <- stores training data frame from X_train.txt
- testFeaturesData <- stores testing data frame from X_test.txt
- trainSubjectID <- stores subject ID's data frame from subject_train.txt
- testSubjectID <- stores subject ID's data frame from subject_test.txt
- trainActivityCode <- stores training activity codes data frame y_train.txt
- testActivityCode <- stores testing activity codes data frame y_test.txt


## Variables:
- featuresData <- row binded trainFeaturesData & testFeaturesData
- subjectID <- row binded subject ID's of training and testing
- activityCode <- row binded activity codes of training and testing
- featuresNames <- stores the features names which are stored in 2nd column of features data frame into a vector
- usefulFeaturesNamesIndex < - using grep() searches and stores indices of "mean" and "std" characters in 2nd column of features(feature names)
- usefulFeaturesNames <- based on usefulFeaturesNamesIndex filters the actual featuresNames having "std" and "mean"
- featuresData <- using select() stores filteres columns of features Data
- mergedData <- column binds SubjectID's, ActivityCodes and featuresData
- tidyData <- summarizes mergedData after grouping by SubjectID and ActivityCodes


## Transformations:
- All the data is loaded into data variables.
- First of all we row bind FeaturesData, ActicityCodes and SubjectID of test and train data.
- Using grep function we find the indices of featureNames having "mean" and "std" characters in it.
- With these indices we filter out the useful features names.
- Using select function of dplyr we select mean and std columns of featuresData with usefulFeaturesNamesIndex.
- Then we assign usefulFeaturesNames to filtered featuresData data frame using colNames function.
- Renames the featuresData column Names by deleting "-" "," and replacing t by time and f by freq using sub function.
- MergedData stores the row binded SubjectID, ActivityCodes and filteres FeaturesData.
- Using mutate and mapvalues (plyr package) functions, we replace the activity codes by activity labels.
- Finally we group the merged data by SubjectID and Activity and finally summarize all columns using summarize_all function.

 
