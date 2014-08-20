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
