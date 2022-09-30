library(tidyverse)

# Preperation
filename <- "UCI_HAR_Dataset.zip"
if(!file.exists(filename)){
      url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
      download.file(url, filename, method = "curl")
}

if(!file.exists("UCI HAR Dataset")){
      unzip(filename)
}

# Input the files
features <- read.table("./UCI HAR Dataset/features.txt",
                       col.names = c("n", "method"))
activities <- read.table("./UCI HAR Dataset/activity_labels.txt",
                         col.names = c("label", "activity"))
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt",
                           col.names = "subject")
x_test <- read.table("./UCI HAR Dataset/test/X_test.txt",
                     col.names = features$method)
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt",
                     col.names = "label")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt",
                            col.names = "subject")
x_train <- read.table("./UCI HAR Dataset/train/X_train.txt",
                      col.names = features$method)
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt",
                      col.names = "label")

# 1. Merges the training and the test sets to create one data set

x <- rbind(x_test, x_train)
y <- rbind(y_test, y_train)
subject <- rbind(subject_test, subject_train)
data <- cbind(subject, x, y)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 

extractdata <- select(data, subject, label,
                      contains("mean"), contains("std"))

# 3. Uses descriptive activity names to name the activities in the data set
extractdata$label <- activities[extractdata$label, "activity"]


# 4. Appropriately labels the data set with descriptive variable names.

names(extractdata)[2] <- "Activity"
names(extractdata) <- gsub("Acc", "Accelerometer", names(extractdata))
names(extractdata) <- gsub("Gryo", "Gyroscope", names(extractdata))
names(extractdata) <- gsub("BodyBody", "Body", names(extractdata))
names(extractdata) <- gsub("Mag", "Magnitude", names(extractdata))
names(extractdata) <- gsub("^t", "Time", names(extractdata))
names(extractdata) <- gsub("^f", "Frequency", names(extractdata))

# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

group_data <- group_by(extractdata, subject, Activity)
final_data <- summarise_all(group_data, funs(mean))
write.table(final_data, "final_data.txt", row.names = F)















