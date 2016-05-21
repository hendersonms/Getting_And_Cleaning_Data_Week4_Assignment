## Getting and Cleaning Data Course
Week 4 Class Project
Matt Henderson

### Description
Comprehensive information about this project can be found on the Coursera Johns Hopkins Getting and Cleaning Data website.  This information can be found here:  (https://www.coursera.org/learn/data-cleaning/peer/FIZtT/getting-and-cleaning-data-course-project)

### Source Data
The full data set for this project can be found in the following location: (http://archive.ics.uci.edu/ml/machine-learning-databases/00240/UCI%20HAR%20Dataset.zip)

All the data set names can be obtained via the followin URL: (http://archive.ics.uci.edu/ml/machine-learning-databases/00240/UCI%20HAR%20Dataset.names)

Data set descriptions can be located at [The UCI Machine Learning Repository](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

### Data Set Information
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

### Source
Jorge L. Reyes-Ortiz(1,2), Davide Anguita(1), Alessandro Ghio(1), Luca Oneto(1) and Xavier Parra(2)
1 - Smartlab - Non-Linear Complex Systems Laboratory
DITEN - Università degli Studi di Genova, Genoa (I-16145), Italy. 
2 - CETpD - Technical Research Centre for Dependency Care and Autonomous Living
Universitat Politècnica de Catalunya (BarcelonaTech). Vilanova i la Geltrú (08800), Spain
activityrecognition '@' smartlab.ws 


### Attribute Information
For each record in the dataset it is provided: 
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration. 
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.


###  Prerequisites 
The reshape2 package will be needed for this script

### Steps and processing offered by the run_analysis.R script
*  The datafile is downloaded and unzipped into a the local working directory
*  The follwoing files are imported and assigned to local variables: 
	-- features.txt
	-- activity_labels.txt
	-- subject_train.txt
	-- subject_test.txt
	-- x_train.txt
	-- y_train.txt
	-- x_test.txt
	-- y_test.txt  
*  Datasets are adorned with column names
*  Training data and Testing data are joined together (and assigned to the TrainAndTestData variable)
*  The measurements on the mean and standard deviation for each measurement (identified by assigning the T/F values to the WhoIsStdvandMean variable)
*  Reassign TrainAndTestData Variable to contain only columns that realate to Std() and mean()
*  Use descriptive activity names to name the activities in the data set by merging the TrainandTestData set with the ActivityType
*  Scrub the column names so they are descriptive and intuitive (i.e.: "Mag", gets changed to  "Magnitude" etc...)
*  Establish a second, independent tidy data set with the average of each variable for each activity and each subject
*  Write out a .csv file that contains the independent tidy data set called "TidyDataSet.csv"
  

