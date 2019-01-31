# Introduction
The script run_analysis.R performs the 5 steps described in the course project's definition.

1. Merges the training and the test sets to create one data set.
the similar data is merged using the rbind() function. 

2. Extracts only the measurements on the mean and standard deviation for each measurement.
only those columns with the mean and standard deviation measures are taken from the whole dataset. After extracting these columns, they are given the correct names.

3. Uses descriptive activity names to name the activities in the data set
Entire numbers in code column of the TidyData replaced with corresponding activity taken from second column of the  activities variable.

4. Appropriately labels the data set with descriptive variable names.
On the whole dataset, those columns with vague column names are corrected. And the columns are appropriately named.
code column in TidyData renamed into activities
All Acc in column’s name replaced by Accelerometer
All Gyro in column’s name replaced by Gyroscope
All BodyBody in column’s name replaced by Body
All Mag in column’s name replaced by Magnitude
All start with character f in column’s name replaced by Frequency
All start with character t in column’s name replaced by Time

5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
We generate a new dataset with all the average measures for each subject and activity type (30 subjects * 6 activities = 180 rows). The output file is called FinalData (180 rows, 88 columns). We create a new txt file for the same.

# Variables
x_train, y_train, x_test, y_test, subject_train and subject_test contain the data from the downloaded files.
x_data, y_data and subject_data merge the previous datasets to further analysis.
features contains the correct names for the x_data dataset, which are applied to the column names stored in mean_and_std_features, a numeric vector used to extract the desired data.
A similar approach is taken with activity names through the activities variable.
all_data merges x_data, y_data and subject_data in a big dataset.
Finally, averages_data contains the relevant averages which will be later stored in a .txt file. ddply() from the plyr package is used to apply colMeans() and ease the development.
