## My R Script for the Course Project of Getting and Cleaning Data 

## Loading the  required Data into R

subject_train <- read.table("./data/subject_train.txt", col.names ="subject")
training_labels <- read.table("./data/y_train.txt", col.names = "activity_id")
training_set <- read.table("./data/X_train.txt")
subject_test <- read.table("./data/subject_test.txt", col.names = "subject")
test_labels <- read.table("./data/y_test.txt", col.names = "activity_id")
test_set <- read.table("./data/X_test.txt")
features <- read.table("./data/features.txt", col.names = c("index", "feature"))
activity_labels <- read.table("./data/activity_labels.txt", col.names = c("activity_id", "activity_name"))

## Combining the training data via cbind
training_data <- cbind(subject_train, training_labels, training_set)

## Combining the test data via cbind
test_data <- cbind(subject_test, test_labels, test_set)

## Naming the columns using features
colnames(training_data)[3:ncol(training_data)] <- features$feature
colnames(test_data)[3:ncol(test_data)] <- features$feature

## Merging both training_data with test_data (rbind)
merged_data <- rbind(training_data, test_data)

## Only extracting the measurements on the mean and standard deviation for each measurement
mean_std_features <- grep("mean\\(\\)|std\\(\\)", features$feature, value = TRUE)
selected_columns <- c("subject", "activity_id", mean_std_features)
extracted_data <- merged_data[, selected_columns]

##Using descriptive activity names to name the activities in the data set
extracted_data <- merge(extracted_data, activity_labels, by = "activity_id", sort = FALSE)

## Appropriately labeling the data set with descriptive variable names
names(extracted_data) <- gsub("^t", "Time", names(extracted_data))
names(extracted_data) <- gsub("^f", "Frequency", names(extracted_data))
names(extracted_data) <- gsub("Acc", "Accelerometer", names(extracted_data))
names(extracted_data) <- gsub("Gyro", "Gyroscope", names(extracted_data))
names(extracted_data) <- gsub("Mag", "Magnitude", names(extracted_data))
names(extracted_data) <- gsub("BodyBody", "Body", names(extracted_data))
names(extracted_data) <- gsub("-mean\\(\\)", "Mean", names(extracted_data), ignore.case = TRUE)
names(extracted_data) <- gsub("-std\\(\\)", "STD", names(extracted_data), ignore.case = TRUE)
names(extracted_data) <- gsub("-", "", names(extracted_data))

## creating a second, independent tidy data set with the average of each variable for each activity and each subject.
library(dplyr)

tidy_data <- extracted_data %>%
  group_by(subject, activity_name) %>%
  summarise(across(where(is.numeric), mean), .groups = "drop")

## Write the tidy data to a file
write.table(tidy_data, "tidy_dataset.txt", row.name = FALSE)
