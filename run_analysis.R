library(plyr)
library(reshape2)
data.dir = "UCI HAR Dataset/"

#step1: Merges the training and the test sets to create one data set
X_test = read.table("UCI HAR Dataset/test/X_test.txt")
y_test = read.table("UCI HAR Dataset/test/y_test.txt")
subject_test = read.table("UCI HAR Dataset/test/subject_test.txt")
# put subject and y at the begining
data.test = cbind(subject_test, y_test, X_test)

X_train = read.table("UCI HAR Dataset/train/X_train.txt")
y_train = read.table("UCI HAR Dataset/train/y_train.txt")
subject_train = read.table("UCI HAR Dataset/train/subject_train.txt")
data.train = cbind(subject_train, y_train, X_train)

data = rbind(data.test, data.train)
colnames(data)[1:2] = c("subject", "label")


#step2: Extracts only the measurements on the mean and standard deviation
#       for each measurement. 
features = read.table("UCI HAR Dataset/features.txt", as.is=T)
colnames(features) = c("index", "name")
cols.selected = grep("(mean|std)\\(\\)", features$name)
data.selected = data[c(1,2, cols.selected+2)] #keep subject and label

#step3: Uses descriptive activity names to name the activities in the data set
labels = read.table("UCI HAR Dataset/activity_labels.txt", as.is=T)
colnames(labels) = c("label", "name")
relabel = mapvalues(factor(data.selected$label), 
                    from=labels$label, to=labels$name)
data.selected$label = relabel

#step4: Appropriately labels the data set with descriptive variable names. 
names = features$name[cols.selected]
# still use t/f notations from the source
# replace "-" with ".", and remvoe parenthesis
names = gsub("-", ".", names)
names = gsub("()", "", names, fixed=T)
#names = gsub("(mean|std)\\.([XYZ])", "\\2.\\1", names)
colnames(data.selected) = c("subject", "activity",names)
#write.table(data.selected, file="selected_data.txt", row.name=F)

#step5: From the data set in step 4, creates a second, independent tidy data set
#       with the average of each variable for each activity and each subject.
data.selected.l = melt(data.selected, id.vars=c("subject", "activity"))
tidy = dcast(data.selected.l, subject + activity ~ variable, fun=mean)
write.table(tidy, file="tidy_data.txt", row.name=F)
