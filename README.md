cleaning-data-with-R
====================

Course project for "Getting &amp; Cleaning Data" on Coursera. This file explains
how the run_analysis.R script works.

What directory to run from
===========================
Download the Samsung Galaxy S smartphone data from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip and unzip it to any directory.
Change to inside that directory and from there run run_analysis.R from the R prompt.

System Requirements
==============
The script loads in a large data set that may not fit into the memory of all machines.
So make sure R can have atleast 90Mb of RAM alloted to it. In other words, if your
computer has about 512MB RAM (most modern ones have atleast this amount), you will be
able to run this without trouble.

What the script does
=====================
* Loads the features contained in X_train and X_test files.
* Extracts only the measurements on the mean and standard deviation for each measurement.
  This is done by hard coding the column numbers of interest. 
* Loads the file that contains subject identifiers (i.e the IDs of the subjects
  who performed each measurement corresponding to the feature files)
* Loads the activity labels file that associates an activity label (eg. WALKING)
  to each measurement example.
* Combines the subject IDs, features and activity labels for each of training and
  test sets to get 2 big merged data sets.
* Merges the training and the test sets to create one data set.
* Uses descriptive activity names to name the activity labels in the data set
* Appropriately labels the data set with descriptive variable names for each of the
  features instead of having cryptic names such as V1, V2 etc.
* Creates a second, independent tidy data set with the average of each variable/feature for each activity and each subject. And writes it out to a file called submission.txt


