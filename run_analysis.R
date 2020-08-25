
library(dplyr)

# Create a filename for the Zip file to be saved as
filename <- "Week4_Assign.zip"

# Check to see if the file already exist, if not download it
if (!file.exists(filename)){
    fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(fileURL, filename, method = "curl")
}

# Check to see if the dataset folder exists, if not unzip the files
if (!file.exists("UCI HAR DataSet")){
        unzip(filename)
}

# Optional list of file names
datapath <- file.path("UCI HAR Dataset")
files = list.files(datapath, recursive = TRUE)

# Create the data frames needed
df_features <- read.table(file.path(datapath, "features.txt"),col.names = c("n","features"))
df_activities <- read.table(file.path(datapath, "activity_labels.txt"),col.names = c("code","activity"))
df_subject_test <- read.table(file.path(datapath, "test","subject_test.txt"),col.names = "subject")
df_x_test <- read.table(file.path(datapath, "test","X_test.txt"),col.names = df_features$features)
df_y_test <- read.table(file.path(datapath, "test", "y_test.txt"),col.names = "code")
df_subject_train <- read.table(file.path(datapath, "train", "subject_train.txt"), col.names = "subject")
df_x_train <- read.table(file.path(datapath, "train", "X_train.txt"),col.names = df_features$features)
df_y_train <- read.table(file.path(datapath, "train", "y_train.txt"),col.names = "code")

# Merge training and test data sets to create one data set
df_train = cbind(df_y_train, df_subject_train, df_x_train)
df_test = cbind(df_y_test, df_subject_test, df_x_test)
df_train_test = rbind(df_train, df_test)

# Extract ony the features that are mean and std
# Creating the data frame with the column names changes the Feature Names by replacing the special char with a period
Feature_Col_Names <- data.frame(features=names(df_train_test))
Mean_STD_Var <- grep("mean\\.\\.|std\\.\\.",Feature_Col_Names$features,value = TRUE)
TD_mean_std <- df_train_test %>% select(subject, code, all_of(Mean_STD_Var))
TD_mean_std$code <- df_activities[TD_mean_std$code, 2]

# Spell out where needed, add underscore after first descriptor
names(TD_mean_std)[2] = "activity"
names(TD_mean_std)<-gsub("Acc","Accelerometer", names(TD_mean_std))
names(TD_mean_std)<-gsub("Gyro","Gyroscope", names(TD_mean_std))
names(TD_mean_std)<-gsub("BodyBody","Body", names(TD_mean_std))
names(TD_mean_std)<-gsub("Mag","Magnitude", names(TD_mean_std))
names(TD_mean_std)<-gsub("^t","time_", names(TD_mean_std))
names(TD_mean_std)<-gsub("^f","frequency_", names(TD_mean_std))
names(TD_mean_std)<-gsub("mean","Mean", names(TD_mean_std))
names(TD_mean_std)<-gsub("std","STD", names(TD_mean_std))
names(TD_mean_std)<-gsub("gravity","Gravity", names(TD_mean_std))


Independent_TD <- TD_mean_std %>%
        group_by(subject, activity) %>%
        summarise_all(funs(mean))
write.table(Independent_TD, "tidydataset.txt", row.names = FALSE)
