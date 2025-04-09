# Codebook for Getting and Cleaning Data (Course Project)

##Original Source

All the original data used in this project is from UCI Machine Learning Repository. Get the Data yourself:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

## Getting a Tidy Data Set

To get a tidy Data Set (tidy_dataset.txt), the following steps were performed:
1 Loading the  required Data into R
2 Merging all the training data into one object called "training_data"
3 Merging all the test data into one object called "test_data"
4 Combining both the traning_data as well as test_data with rbind
5 Extracting only measurements related to mean and standard deviation
6 Adding descriptive activity names
7 Reanming variables to make them more descriptive
8 Creating a tidy dataset with the average of each variable for each subject and activity combination

Please note, that the full code can be accessed by the file run_analysis.R in my GitHub repo called GettingAndCleaningData. 

## Tody Data Set: An Overview

The tidy_dataset.txt contains **180 observations** and **68 variables**. 
- "subject": Describes the person who performed a specific activity (integer from 1-30)
- "activity_name": Name of the activity performed (e.g. WALKING, SITTING, ...)
- The **66 variables** that remain, are **average values of the mean and standard deviation measurements** 
  for each for each combination of subject and activity.
  
Example variable names include:
- "TimeBodyAccelerometerMeanX"
- "FrequencyBodyAccelerometerMean"

All values are numeric and unitless (normalized).

## Units

All measurements are normalized and unitless, as provided in the original dataset.
