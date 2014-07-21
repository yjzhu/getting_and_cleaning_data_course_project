getting_and_cleaning_data_course_project
========================================

### Description on run_analysis.R

1. Make sure the data set and run_analysis.R are in the same directory.

2. Inputs for run_analysis.R 
- X_train.txt
- X_test.txt
- features.txt
- y_train.txt
- y_test.txt
- activity_labels.txt
- subject_train.txt
- subject_test.txt

3. Outputs for run_analysis.R
- tidy.txt

4. Command used for running run_analysis.R
- source("run_analysis.R")

5. Detailed dscription on run_analysis.R

- Read X_train.txt and X_test.txt, merge them together to form a data set called new.
- Read features.txt.
- Select indices for features that contain mean() and std().
- Create a new data set new.mean.std by selecitng only feacutres that contain mean() and std().
- Set names for the features.
- Read y_train.txt and y_test.txt, merge them together to form a data set called new.activity.
- Read activity_labels.txt.
- Set names for new.activity.
- Read subject_train.txt and subject_test.txt, merge them together to form a data set called new.subject.
- Set names for new.subject.
- Define a new data frame based on created new data set.
- Set column names for the new data frame. 
- Fill in the data frame.
- Write the new dataset to the disk.




