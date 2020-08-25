# **Code Book**

The *run_analysis.R* script performs the following 5 steps required for the Getting and Cleaning Data Course Project

**1. Merges the training and the test sets to create one data set**
        * Download dataset
                + Download the file
                + unzip the file into a folder called **UCI HAR Dataset**
        * Create the required dataframes
                + Generate the dataframes based on the files needed, with column names added
        * Merge the two sets to create one data set
                + Combine the three dataframes for the training data set
                + Combine the three dataframes for the test data set
                + Merge the training and test data sets
                
**2. Extracts only the measurements on the mean and standard deviation for each measurement**
        * Utilize grep to capture only the mean and standard deviation variables

**3. Uses descriptive activity names to name the activities in the data set**
        * change the code to the activity name

**4. Appropriately labels the data set with descriptive variable names**
        * change Acc to Accelerometer
        * change Gyro to Gyroscope
        * change BodyBody to Body
        * change Mag to Magnitude
        * change varialable starting with t to time_
        * change varialable starting with f to frequency_
        * change mean to Mean
        * change std to STD
        * change gravity to Gravity

**5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject**
        * Create a final tidy dataset, grouping by the subject and activity, then sumarizing
        * Write final tidy dataset to a file
