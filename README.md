# GettingandCleaningDataProgrammingAssignment
Programming assignment for Getting and Cleaning Data course on Coursera.

## About the data set
The data set used in this project was the Human Activity Recognition Using Smartphones Data Set.
It was downloaded from UCI's Machine Learning Repository.
The study collected data from subjects wearing a smartphone with sensors measuring body movement.
30 subjects participated in the study.
The activities they completed included walking, walking up stairs, walking down stairs, sitting, standing, and laying down.
The data set contained 10,299 observations on 561 variables. There were six separate txt files, one for subject id in the training group, 
one for subject id in the testing group, one for the activities in the training group, one for activities in the testing group,
one for the measurements in the training group, and one for the measurements in the testing group. The txt files did not have headers.

## Reading in the data files
The first goal was to read in the data files and create column names. I used read.table, specifying header=FALSE, and using col.names
to create column names. For the files containing only subjects, I created the column name "subjectid." For the files containing the 
activities, I created the column name "activity." The features the smartphone measured were contained in a separate txt file called
"features." When reading in the measurement files, I specified that the column names should be the names of the features from the 
features file.

## Merging the test and train data sets
The second goal was to merge the test and train data sets into one data set. To begin, I used cbind to create a data frame called
"testdata" which combined the subject_test, y_test, and X_test data files. I repeated this process to create a data frame called "traindata"
which combined the subject_train, y_train, and X_train data files. Finally, I used rbind to combine the testdata and traindata data frames
into one large data frame called "alldata."

## Extracting columns on mean and standard deviation.
The third goal was to extract only the columns having to do with measurements of mean and standard deviation. To do this, I created a 
data frame called "neededdata" and used the "select" and "contains" fuctions in dplyr to select only the columns containing "mean" and
"std" as well as the "subjectid" and "activity" columns. This yielded a new data frame of 10,299 observations and 88 columns.

## Changing the activity numbers to activity names.
The next goal was to change the activity numbers 1-6 into descriptive names describing the activity (i.e. walking or sitting). To
accomplish this, I used the "transform" function to transform the activity column into a factor variable with levels 1-6 and labels "walking", "walking upstairs",
"walking downstairs", "sitting", "standing", and "laying" according to the key in the "activity_labels" txt file in the data set.

## Cleaning up the column names.
The column names were already descriptive according to the labels in the "features" text file. To make them easier to read, I used "gsub"
to remove the unnecessary periods and make the full column name readable.

## Creating a tidy, summarized data frame with the average of each variable for each activity and each subject.
The final step was to create a tidy, summarized data frame with the average of each variable for each activity and each subject. To
accomplish this, I first used "group_by" to group the data by activity, and then by subject id. Next, I used "summarize_all" on
the grouped data with the function "mean."

## Files contained in this repo
Files contained in this repo include the final tidy, summarized data frame. This is a file called "summarizeddata.txt." This repo also includes
the R script with the code the accomplished this analysis. This is a file called "run_analysis.R." Finally, there is a codebook.
