library(plyr)
##1st PART

##if directory doesn't exist, creates new
if(!file.exists("./data")){
	dir.create("./data")}

fileUrl <- "http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip" 
download.file(fileUrl, destfile="./data/project.zip")
setwd("./data")
unzip("project.zip", files=NULL, list=FALSE, overwrite=TRUE, junkpaths=FALSE, exdir=".", unzip="internal", setTimes=FALSE)

##reads train and test sets
trainX<- read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt", header=FALSE)
trainY<- read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/Y_train.txt", header=FALSE)
trainSubject<- read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt", header=FALSE)

testX<- read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt", header=FALSE)
testY<- read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/Y_test.txt", header=FALSE)
testSubject<- read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt", header=FALSE)
##reads other files
activityLabels<-read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/activity_labels.txt", col.names= c("Label", "Activity"),  colClasses = c('numeric', 'character'))
features<-read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/features.txt", colClasses = c("character"))

##Merges train and test sets to one data set
trainSet<-cbind(cbind(trainX, trainSubject), trainY)
testSet<-cbind(cbind(testX, testSubject), testY)
fullSet<- rbind(trainSet, testSet)

##Labels two last columns
fullSetLabels<- rbind(rbind(features, c(562, "Subject")), c(563, "ActivityId"))[,2]
names(fullSet) <-fullSetLabels

##2nd PART

##Extracts measurements on the mean and standart deviation for each measurement
fullSet_Mean_Std<- fullSet[,grepl("mean|std|Subject|ActivityId", names(fullSet))]

##3rd PART
##Uses descriptive activity names to name the activities in the data set
fullSet_Mean_Std <- merge(fullSet_Mean_Std, activityLabels, by.x= 'ActivityId', by.y='Label')
##Remove ActivityId column
fullSet_Mean_Std<- fullSet_Mean_Std[,!(names(fullSet_Mean_Std)%in%c('ActivityId'))]

##4th PART
##Appropriately labels the data set with descriptive variable names.
names(fullSet_Mean_Std) <- gsub('Acc',"Acceleration",names(fullSet_Mean_Std))
names(fullSet_Mean_Std) <- gsub('GyroJerk',"AngularAcceleration",names(fullSet_Mean_Std))
names(fullSet_Mean_Std) <- gsub('Gyro',"AngularSpeed",names(fullSet_Mean_Std))
names(fullSet_Mean_Std) <- gsub('Mag',"Magnitude",names(fullSet_Mean_Std))
names(fullSet_Mean_Std) <- gsub('^t',"TimeDomain.",names(fullSet_Mean_Std))
names(fullSet_Mean_Std) <- gsub('^f',"FrequencyDomain.",names(fullSet_Mean_Std))
names(fullSet_Mean_Std) <- gsub('-mean()',".Mean",names(fullSet_Mean_Std))
names(fullSet_Mean_Std) <- gsub('-std()',".StandardDeviation",names(fullSet_Mean_Std))
names(fullSet_Mean_Std) <- gsub('Freq\\.',"Frequency.",names(fullSet_Mean_Std))
names(fullSet_Mean_Std) <- gsub('Freq$',"Frequency",names(fullSet_Mean_Std))

##5th PART
##Creates a second, independent tidy data set with the average of each variable for each activity and each subject
IndependentData <- ddply(fullSet_Mean_Std, c("Subject","Activity"), numcolwise(mean))
write.table(IndependentData, file = "IndependentData.txt")
