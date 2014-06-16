GettingCleaningDataProject
==========================

Files for Coursera "Getting and Cleaning Data" Course Project


- Processing the data

There are five main stages of processing the data:

1. Merge the training and the test sets to create one data set.
2. Extract only the measurements on the mean and standard deviation for each measurement. 
3. Use descriptive activity names to name the activities in the data set
4. Appropriately label the data set with descriptive variable names. 
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

These five stages are marked within the R script for clarity ("run_analysis.R")

The final tidy dataset produced by the R script is called "tidy_dataset.txt" - 180 observations of 88 variables.



- Assumptions and choices made in processing data

Step 2 is ambiguous regarding the extraction of mean and standard deviation. Therefore I choose to extract any variables that contained the character strings "mean", "std" or "Mean". This probably includes more data than is required but it is easier to ignore or delete unwanted information rather than return to the original data files and extract any required missing data.

Step 4 requires to "appropriately label the data" but it is unclear what this means. I interpreted it as excluding any punctuation in order that the columns can be refered to (and sorted/analysed) by name. 

Step 5 averages the values for each subject (1-30) for each activity (1-6) creating 180 observations. 

- Processed data description

The "subject" column refers to the individual person (1-30)
The "activty" column refers to the activity they were undertaking when the measurement was taken (6 options)
The other 86 columns refer to the type of measurement taken. A full description of these measurements can be found in "features_info.txt" included in the original data. These variables are all without unit (as the data has been scaled by dividing by the range)



- Original data

This should be placed and unzipped in the working directory. The R Script will then read and import the relevant files.
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

A description of the original data can be found here:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones


        
        
