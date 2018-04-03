
## Data Source
* Data can be downloaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
* For more information about the data, please read from http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

## Data Used 
* './test/X_test.txt'
  * This file shows all the measurements' statistics for the activities completed for each subject.
* './test/Y_test.txt'
  * This file is the activity's label for each observation in the X_test files 
* './test/subject_test.txt'
  * This file is the subject's label for each observation in the X_test files 
* './train/X_train.txt'
  * This file shows all the measurements' statistics for the activities completed for each subject.
* './train/Y_train.txt'
  * This file is the activity's label for each observation in the X_train files 
* './train/subject_train.txt'
  * This file is the subject's label for each observation in the X_train files 
* './features.txt'
  * This file is the variable names for the data X_test and X_train 
* './activity_label.txt'
  * This file is the activity list with both descriptive value and numerical value 

## Process in R-script
* Read all eight files above 
* Merge all tests and train files e.g. X_test and X_train, Y_test and Y_train, subject_test and subject_train
* Merge the the merged data from the previous process with the following order, subject, Y_test_train, X_test_train
