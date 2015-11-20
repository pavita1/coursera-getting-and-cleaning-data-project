# Step -3
# download the data and create folder if it doesnt exists

if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./data/Dataset.zip",method="curl")

# Step -2
# unzip the file
unzip(zipfile="./data/Dataset.zip",exdir="./Users/LP/Desktop/COURSERA/GETTING-AND-CLEANING-DATA/UCI HAR Dataset")

# Step -1
#set working directory to the location where the UCI HAR Dataset was unzipped
setwd("/Users/LP/Desktop/COURSERA/GETTING-AND-CLEANING-DATA/UCI HAR Dataset/")

# Step 1
# load (dplyr) package, read and merge "training" and "test" data sets to create one data set

library(dplyr)
x_train <- read.table("train/X_train.txt")
y_train <- read.table("train/y_train.txt")
subject_train <- read.table("train/subject_train.txt")

x_test <- read.table("test/X_test.txt")
y_test <- read.table("test/y_test.txt")
subject_test <- read.table("test/subject_test.txt")

# merge "X"s (Features) , "y"s (Activity) and "subject"s (Subject) data sets

x_data <- rbind(x_train, x_test)
y_data <- rbind(y_train, y_test)
subject_data <- rbind(subject_train, subject_test)

# Step 2
# extract only mean and standard deviation for each measurement
# read and view features
features <- read.table("features.txt")
View(features)

# extract only columns with "mean" or "std" in their names (using regular expressions and finding values)
mean_std_features <- grep("-(mean|std)\\(\\)", features[, 2])

# subset the "mean" and "std" columns and correct the column names
x_data <- x_data[, mean_std_features]
names(x_data) <- features[mean_std_features, 2]
View(x_data)

# Step 3
# Use descriptive activity names to name the activities in the data set
# read and view "activities"

activities <- read.table("activity_labels.txt")
View(activities)
View(y_data)

# update values with correct activity names
y_data[, 1] <- activities[y_data[, 1], 2]

# correct column name
names(y_data) <- "activity"

# Step 4
# Appropriately label the data set with descriptive variable names

# correct column name in "subject_data" dataset
View(subject_data)
names(subject_data) <- "subject"

View(subject_data)

# merge by column all the data into one data set
merged_data <- cbind(x_data, y_data, subject_data)
View(merged_data)
dim(merged_data)
# [1] 10299    68

# Step 5
# From data set in step4, create a second, independent tidy data set with the average of each variable
# for each activity and each subject

# calculate avg of dataset "merged_data" but skip last two columns "activity" and "subject" (67,68)
avg_data <- ddply(merged_data, .(subject, activity), function(x) colMeans(x[, 1:66]))
View(avg_data)
write.table(avg_data, "tidy.txt", row.name=FALSE)

# produce code book
library(knitr)
knit2html("CodeBook.md")
