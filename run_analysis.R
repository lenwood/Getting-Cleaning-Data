# Create one R script called run_analysis.R that does the following.
#
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# 3. Uses descriptive activity names to name the activities in the data set.
# 4. Appropriately labels the data set with descriptive variable names.
# 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# read all of the data
test_x <- read.table("UCI HAR Dataset/test/X_test.txt", sep="", header=FALSE, nrow=3000)
train_x <- read.table("UCI HAR Dataset/train/X_train.txt", sep="", header=FALSE, nrow=7400)
test_y <- read.table("UCI HAR Dataset/test/y_test.txt", sep="", header=FALSE, nrow=3000)
train_y <- read.table("UCI HAR Dataset/train/y_train.txt", sep="", header=FALSE, nrow=7400)
testSubject <- read.table("UCI HAR Dataset/test/subject_test.txt", sep="", nrow=3000)
trainSubject <- read.table("UCI HAR Dataset/train/subject_train.txt", sep="", nrow=7400)
activities <- read.table("UCI HAR Dataset/activity_labels.txt", sep="", header=FALSE)
features <- read.table("UCI HAR Dataset/features.txt", sep="", header=FALSE, nrow=600)


## 1.
# Merge test & train into one data set.
data <- rbind(test_x, train_x)

rm(test_x, train_x)


## 4. Set variable names according to features.txt
features$V1 <- NULL
features <- t(features)
names(data) <- features
rm(features)


## 2. Extract mean & standard deviation for each measurements.
mean <- grep("mean()", colnames(data), fixed=TRUE)
SD <- grep("std()", colnames(data), fixed=TRUE)

data <- data[, c(mean, SD)]
rm(mean, SD)


## 3. Add activity labels
# add the labels to the dataset
data_y <- rbind(test_y, train_y)
rm(test_y, train_y)
names(data_y) <- "label"

data <- cbind(data, data_y)
rm(data_y)

activities$V1 <- NULL
activities <- t(activities)
data$activityName <- as.factor(data$label)
levels(data$activityName) <- activities
rm(activities)
data$label <- NULL

# add the subject to the data frame
subject <- rbind(testSubject, trainSubject)
names(subject) <- "subject"
data <- cbind(data, subject)
data$subject <- as.factor(data$subject)
rm(subject, testSubject, trainSubject)

# reorder columns
data <- data[, c(68:67, 1:66)]


## 5. Create a tidy data set
tidySet <- aggregate(data[,3] ~ subject + activityName, data=data, FUN="mean")

for(i in 4:ncol(data)){
	tidySet[,i] <- aggregate(data[,i] ~ subject + activityName, data=data, FUN="mean")[,3]
}

names(tidySet) <- names(data)

write.table(tidySet, file="tidySet.txt", row.names=FALSE)
