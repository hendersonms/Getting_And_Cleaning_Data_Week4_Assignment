
##----------------------------------------------------##
##  Week 4 Class Project for Geting and Cleaning Data
##  Matt Henderson
##  5/21/2016

##  Assignment instructions

##  Data Source  
##  https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

##  You should create one R script called run_analysis.R that does the following. 
##  1.Merges the training and the test sets to create one data set.
##  2.Extracts only the measurements on the mean and standard deviation for each measurement. 
##  3.Uses descriptive activity names to name the activities in the data set
##  4.Appropriately labels the data set with descriptive variable names. 
##  5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
##----------------------------------------------------##

##  Load the various librarys that will be needed within the script
library(reshape2)  ## Needed for melt() call

## ---- Step 1 Merge the training and the test sets to create one data set. ---- ##
##  Download the file to local directory
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
download.file(fileUrl, destfile="week4classproject.zip" , mode='wb')

## Unzip the file 
unzip("week4classproject.zip", files = NULL, list = FALSE, overwrite = TRUE, junkpaths = FALSE, exdir = ".", unzip = "internal",setTimes = FALSE)

##  Pull in all data / meta data from downloadedfiles for both Training and Test Data
features     <- read.table('./UCI HAR Dataset/features.txt',header=FALSE)   ## imports features.txt
activityType <- read.table('./UCI HAR Dataset/activity_labels.txt',header=FALSE)   ## imports activity_labels.txt
subjectTrain <- read.table('./UCI HAR Dataset/train/subject_train.txt',header=FALSE)   ## imports subject_train.txt
subjectTest  <-read.table('./UCI HAR Dataset/test/subject_test.txt',header=FALSE)  #imports subject_test.txt
TrainingX      <- read.table('./UCI HAR Dataset/train/x_train.txt',header=FALSE) ## imports x_train.txt
TrainingY      <- read.table('./UCI HAR Dataset/train/y_train.txt',header=FALSE)   ## imports y_train.txt
TestingX       <- read.table('./UCI HAR Dataset/test/x_test.txt',header=FALSE)  #imports x_test.txt
TestingY      <- read.table('./UCI HAR Dataset/test/y_test.txt',header=FALSE)  #imports y_test.txt

##  Establish Column Names for training and test data
colnames(activityType)  <- c('activityId','activityType')
colnames(subjectTrain)  <- "subjectId"
colnames(subjectTest)   <- "subjectId"
colnames(TrainingX)     <- features[,2] 
colnames(TrainingY)     <- "activityId"
colnames(TestingX)      <- features[,2] 
colnames(TestingY)      <- "activityId"

##  Establish a final data set for the training and testing data
TrainData <- cbind(TrainingY,subjectTrain,TrainingX)
TestData <- cbind(TestingY,subjectTest,TestingX)

##  Join Testing and Training Data together into a single dataset
TrainAndTestData <-  rbind(TestData, TrainData)
## ----   End of Step 1  ---- ##



## ---- Step 2 Extract  the measurements on the mean and standard deviation for each measurement---- ##
##  Identify which columns are Standard Dev and Mean Columns
WhoIsStdvandMean = (grepl("activity..",colnames(TrainAndTestData)) 
              | grepl("subject..",colnames(TrainAndTestData)) 
              | grepl("-mean..",colnames(TrainAndTestData)) 
              & !grepl("-meanFreq..",colnames(TrainAndTestData)) 
              & !grepl("mean..-",colnames(TrainAndTestData)) 
              | grepl("-std..",colnames(TrainAndTestData)) 
              & !grepl("-std()..-",colnames(TrainAndTestData)))

# Reassign TrainAndTestData Variable to contain only columns that realate to Std() and mean()
TrainAndTestData <- TrainAndTestData[WhoIsStdvandMean==TRUE]
## ----   End of Step 2  ---- ##




## ---- Step 3 Use descriptive activity names to name the activities in the data set---- ##

##  Join the activityType to the remainder of the TrainandTestData Data set On the ActivityID column
TrainAndTestData <- merge(TrainAndTestData,activityType,by='activityId',all.x=TRUE)
## ----   End of Step 3  ---- ##


  
  
## ---- Step 4 Use descriptive activity names to name the activities in the data set---- ##
##  Update column names --remove abbreviations and make names more meaningful using gsub() and some RegExs
  names(TrainAndTestData)<-gsub("std()", "standarddeviation", names(TrainAndTestData))
  names(TrainAndTestData)<-gsub("mean()", "mean", names(TrainAndTestData))
  names(TrainAndTestData)<-gsub("^t", "time", names(TrainAndTestData))
  names(TrainAndTestData)<-gsub("^f", "frequency", names(TrainAndTestData))
  names(TrainAndTestData)<-gsub("Acc", "Accelerometer", names(TrainAndTestData))
  names(TrainAndTestData)<-gsub("Gyro", "Gyroscope", names(TrainAndTestData))
  names(TrainAndTestData)<-gsub("Mag", "Magnitude", names(TrainAndTestData))
  names(TrainAndTestData)<-gsub("BodyBody", "Body", names(TrainAndTestData))
  ## ----   End of Step 4  ---- ##
  
 
  ## ---- Step 5 Creates a second, independent tidy data set with the average of each variable for each activity and each subject.---- ##
  
  ## average of each variable for each activity and each subject.
  # create the tidy data set
  melted <- melt(TrainAndTestData, id=c("subjectId","activityType"))
  TidyDataSet <- dcast(melted, subjectId+activityType ~ variable, mean)
  
  # write the tidy data set to a file
  write.csv(TidyDataSet, "TidyDataSet.csv", row.names=TRUE)
  ## ----   End of Step 5  ---- ##

  
  
  
  
  
