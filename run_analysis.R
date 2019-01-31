library(plyr)

#assign data frames
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")


#Merge the training and the test sets to create one data set.

x_train <- read.table("train/X_train.txt")
y_train <- read.table("train/y_train.txt")
subject_train <- read.table("train/subject_train.txt")

x_test <- read.table("test/X_test.txt")
y_test <- read.table("test/y_test.txt")
subject_test <- read.table("test/subject_test.txt")

X <- rbind(x_train, x_test)
Y <- rbind(y_train, y_test)

subject_data <- rbind(subject_train, subject_test)
#to create 'subject' data set

Subject <- rbind(subject_train, subject_test)

Merged_Data <- cbind(Subject, Y, X)


#Extract only the measurements on the mean and standard deviation for each measurement
TidyData <- Merged_Data %>% select(subject, code, contains("mean"), contains("std"))


#Use descriptive activity names to name the activities in the data set
TidyData$code <- activities[TidyData$code, 2]

#Appropriately labels the data set with descriptive variable names.
names(TidyData)[2] = "activity"
names(TidyData)<-gsub("Acc", "Accelerometer", names(TidyData))
names(TidyData)<-gsub("Gyro", "Gyroscope", names(TidyData))
names(TidyData)<-gsub("BodyBody", "Body", names(TidyData))
names(TidyData)<-gsub("Mag", "Magnitude", names(TidyData))
names(TidyData)<-gsub("^t", "Time", names(TidyData))
names(TidyData)<-gsub("^f", "Frequency", names(TidyData))
names(TidyData)<-gsub("tBody", "TimeBody", names(TidyData))
names(TidyData)<-gsub("-mean()", "Mean", names(TidyData), ignore.case = TRUE)
names(TidyData)<-gsub("-std()", "STD", names(TidyData), ignore.case = TRUE)
names(TidyData)<-gsub("-freq()", "Frequency", names(TidyData), ignore.case = TRUE)
names(TidyData)<-gsub("angle", "Angle", names(TidyData))
names(TidyData)<-gsub("gravity", "Gravity", names(TidyData))

#Create a second, independent tidy data set with the average of each variable for each activity and each subject.
FinalData <- TidyData %>%
    group_by(subject, activity) %>%
    summarise_all(funs(mean))
write.table(FinalData, "FinalData.txt", row.name=FALSE)

#Check variable names
str(FinalData)

#View final data
FinalData

