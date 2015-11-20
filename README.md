# coursera-getting-and-cleaning-data-project
course project for Coursera "Getting and Cleaning Data" 

This is the course project for the Getting and Cleaning Data Coursera course. The R script, run_analysis.R, does the following:

   preparation steps: (-3,-2,-1)
      Download the dataset if it does not already exist in the working directory
   start process:
   1. Loads both the training and test datasets, merges the two datasets 
   2. extracts only those columns which contain the mean or standard deviation in its name
   3. Loads the activity data for each dataset, update values with correct activity names and correct column names
   4. Loads the subject data for each dataset, and merges those columns with the dataset
   5. Creates a tidy dataset that consists of the average (mean) value of each variable for each subject and             activity pair.

The end result is shown in the file tidy.txt.
