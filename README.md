# CleaningDataProject
Course project for JHU's Getting and Cleaning Data course on Coursera


franceshuisman


Data were obtained from the following source:

  https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Tables for the Test and Train sample groups were assembled from files 'subject_test.txt', 'y_test.txt', 'x_test.txt' (for Test data), or 'subject_train.txt', 'y_train.txt', and 'x_train.txt' (for Train data) as follows.

First, variable names were assigned to each column of the 'x_test.txt'/'x_train.txt' data from the 'features.txt' file. Then the mean and standard deviation data were selected by selecting for columns ending in 'mean()' or 'std()'. Finally the edited 'x' data were clipped to their associated 'y' and 'subject' data.

These final Test and Train tables were clipped together to form a combined data table. Activity labels (1-6, representing WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING and LAYING respectively), were assigned by joining with the 'activity_labels.txt' data. The redundant numerical activity label column was removed, and data were summarised by the mean of each variable for each subject/activity combination.


The project contains the following files:

 - 'README.md'
 - 'wearablesmean.txt': A tidy data set of average variable means and standard deviations, by activity and subject.
 - 'CodeBook.md': Descriptions of the variables in 'wearablesmean.txt'
 - 'run_analysis.R': The script used to create 'wearablesmean.txt' from the 'Human Activity Recognition Using Smartphones Dataset', Version 1.0

