# 1.Merges the training and the test sets to create one data set.
# 2.Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3.Uses descriptive activity names to name the activities in the data set
# 4.Appropriately labels the data set with descriptive variable names. 
# 5.Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 


# train/X_train.txt: Training set.
# test/X_test.txt: Test set.
# Read X_train.txt and X_test.txt, merge them together to form a data set called new

train.set <- read.table("UCI HAR Dataset/train/X_train.txt")
test.set <- read.table("UCI HAR Dataset/test/X_test.txt")
new <- rbind(train.set, test.set)


# features.txt: Features
# Read features.txt
# Select indices for features that contain mean() and std()
# Create a new data set new.mean.std by selecitng only feacutres that contain mean() and std()
# Set names for the features 

features <- read.table("UCI HAR Dataset/features.txt")
indices.mean.std <- grep("mean\\(\\)|std\\(\\)", features[,2])
new.mean.std <- new[,indices.mean.std]
names.new.mean.std <- features[indices.mean.std,2]
names(new.mean.std) <- names.new.mean.std

# train/y_train.txt: Training labels.
# test/y_test.txt: Test labels.
# activity_labels.txt: Links the class labels with their activity name.
# Read y_train.txt and y_test.txt, merge them together to form a data set called new.activity
# Read activity_labels.txt
# Set names for new.activity

train.activity <- read.table("UCI HAR Dataset/train/y_train.txt")
test.activity <- read.table("UCI HAR Dataset/test/y_test.txt")
new.activity <- rbind(train.activity, test.activity)
activity.labels <- read.table("UCI HAR Dataset/activity_labels.txt")
activity <- activity.labels[new.activity[,1],2]
new.activity[,1] <- activity
names(new.activity) <- "activity"


# train/subject_train.txt: Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.
# test/subject_test.txt: similar to above
# Read subject_train.txt and subject_test.txt, merge them together to form a data set called new.subject
# Set names for new.subject

train.subject <- read.table("UCI HAR Dataset/train/subject_train.txt")
test.subject <- read.table("UCI HAR Dataset/test/subject_test.txt")
new.subject <- rbind(train.subject, test.subject)
names(new.subject) <- "subject"

# Create a new tidy data set
tidy <- cbind(new.subject, new.activity, new.mean.std)

subject.set <- sort(unique(tidy$subject))
num.subject <- length(subject.set)
activity.set <- sort(unique(tidy$activity))
num.activity <- length(activity.set)
num.col.tidy <- dim(tidy)[2]

# Define a new data frame based on above values
tidy2 <- as.data.frame(matrix(NA, nrow = num.subject * num.activity, ncol = num.col.tidy))

# Set column names 
names(tidy2) <- gsub("^", "Average_", names(tidy))
names(tidy2)[1] <- "subject"
names(tidy2)[2] <- "activity"

# Fill in the data frame
num.row <-1

for(i in 1 : num.subject) {
  for (j in 1: num.activity) {
    tidy2[num.row, 1] <- subject.set[i]
    tidy2[num.row, 2] <- activity.set[j]
    flag.subject <- subject.set[i] == tidy$subject
    flag.activity <- activity.set[j] == tidy$activity
    tidy2[num.row, 3:num.col.tidy] <- colMeans(tidy[flag.subject & flag.activity, 3:num.col.tidy])
    num.row <- num.row +1
  }
}

# Write the new dataset to the disk
write.table(tidy2, "UCI HAR Dataset/tidy.txt", row.names=FALSE)
write.table(names(tidy2), "UCI HAR Dataset/CodeBook.md", quote=FALSE, col.names=FALSE)



