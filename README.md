# getdata course project
This is the course project for getting and cleaning data on coursera. An exercise
aiming generating tidy data from wearalbe computing sensor data. The raw data is in directory "*UCI HAR Dataset*", result data in file *tidy\_data.txt*, and the code is  *run\_analysis.R*.

## analysis
the run\_analysis.R merged the data from test set and train set, extraced only the
mean and standard deviation features, calculated the mean of each feature for 
each activity and each subject, and tried to form it nicely.

## result format
There are 180 rows and 68 columns in the result. Each row for
the measurements for a subject and activity. The colnames in the  mainly inherent the feature notation from the origin dataset. Concretely, the first two columns
are subject and activity, and the rest columns are the mean of measurements of features. Each feature is named as *measurement.(std|mean)[.(X|Y|Z)]* . For the meaning of measurement and technical details, please refer to "*UCI HAR Dataset/features_info.txt"*" for details.