#Code Book

#####The script run_analysis.R
1. Merges the training and the test sets to create one data set
2. Extracts only the measurements on the mean and standard deviation for each measurement
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject

#####Variables

1. fileUrl - identifies link from where you can download data
2. trainX - identifies training set
3. trainY - identifies training labels
4. trainSubject - identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
5. testX - identifies test set
6. testY - identifies test labels
7. testSubject - identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
8. activityLabels - identifies a specific activity subject did. It has 6 different type of activities, including "WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", and "LAYING"
9. features - identifies list of all features(labels)
10. trainSet - identifies merged variables trainX , trainY, trainSubject
11. testSet - identifies merged variables testX , testY, testSubject
12. fullSet - identifies merged variables trainSet and testSet
13. fullSetLabels - identifies all labels of fullSet including label 'Subject' and 'ActivityId'
14. fullSet_Mean_Std - identifies extracted measurements on the mean and standart deviation from variable fullSet
15. IndependentData -identifies data set with average of each variable for each activity of each subject from fullSet_Mean_Std

#####The Original Data Set
* The original data set is split into training and test sets (70% and 30%, respectively) where each partition is also split into three files that contain
 * measurements from the accelerometer and gyroscope
 * activity label
 * identifier of the subject
 
#####Transformation 
* Uses library 'plyr'
* Checks if directory exists, if not creates the new directory
* Uses link https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip  and downloads zip file to that directory
* Extract files to folder from zip file
* Reads data to variables trainX, trainY, trainSubject, testX, testY, testSubject, activityLabels, features
* Merges train data to one data set trainSet and merges test data to testSet
* Merges datas trainSet and testSet to one data set fullSet
* Labels all columns including two last columns and these columns labels by names 'Subject' and 'ActivityId'
* Keeps only columns which contains mean() or std() in column names since they are the measurements we need and create new dataSet fullSet_Mean_Std
* Merges new data set fullSet_Mean_Std with Activities by Activity Id
* Removes Activity Id column
* Labels variables of data set with descriptive names 
* Creates new data set IndependentData from data set fullSet_Mean_Std by calculating means of Subjects and Activities for each variable
* Creates new txt file IndependentData with that data set inside
 
 
