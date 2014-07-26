# This script should be run inside the unzipped folder of the Samsung data set.
library(reshape2)

# Read the training and the test set feature file
train <- read.table("train/X_train.txt")
test <- read.table("test/X_test.txt")

# Extracts only the measurements on the mean and standard deviation for each measurement. The column numbers
# are hard coded here.
mean_feature_columns <- c(1,2,3,41,42,43,81,82,83,121,122,123,161,162,163,201,214,227,240,253,266,267,268,345,346,347,424,425,426,503,516,529,542)
train <- train[, mean_feature_columns]
test <- test[, mean_feature_columns]

# Read in the ids of the subjects with whom each measurement is related to.
subject_train <- read.table("train/subject_train.txt", col.names = c("SubjectIdentifier"))
subject_test <- read.table("test/subject_test.txt", col.names = c("SubjectIdentifier"))

# Read in the data label id  for each data point in both the training and test data.
y_train <- read.table("train/Y_train.txt", col.names = c("ActivitylabelID"))
y_test <- read.table("test/Y_test.txt", col.names = c("ActivitylabelID"))

# Read in descriptive names associated with the activity id recorded in the Y labels file.
activity_names <- read.table("activity_labels.txt", col.names = c("Num", "ActivityLabel"))

# Combine all the data together.
all_train <- cbind(subject_train, train, y_train)
all_test <- cbind(subject_test, test, y_test)
all_data <- rbind(all_train, all_test)

# Removing unwanted variables from the workspace to save memory. This is optional.
remove(all_train, all_test, train, test, subject_train, subject_test, y_train, y_test)

# Appropriately labels the data set with descriptive variable names.
names(all_data)[2:34] <- c("timeDomain.BodyAcceleration.X.Mean",
                               "timeDomain.BodyAcceleration.Y.Mean",
                               "timeDomain.BodyAcceleration.Z.Mean",
                               "timeDomain.GravityAcceleration.X.Mean",
                               "timeDomain.GravityAcceleration.Y.Mean",
                               "timeDomain.GravityAcceleration.Z.Mean",
                               "timeDomain.BodyAcceleration.LinearAcceleration.Jerk.X.Mean",
                               "timeDomain.BodyAcceleration.LinearAcceleration.Jerk.Y.Mean",
                               "timeDomain.BodyAcceleration.LinearAcceleration.Jerk.Z.Mean",
                               "timeDomain.BodyAcceleration.Gyroscope.X.Mean",
                               "timeDomain.BodyAcceleration.Gyroscope.Y.Mean",
                               "timeDomain.BodyAcceleration.Gyroscope.Z.Mean",
                               "timeDomain.BodyAcceleration.Gyroscope.Jerk.X.Mean",
                               "timeDomain.BodyAcceleration.Gyroscope.Jerk.Y.Mean",
                               "timeDomain.BodyAcceleration.Gyroscope.Jerk.Z.Mean",
                               "timeDomain.BodyAcceleration.Magnitude.Mean",
                               "timeDomain.GravityAcceleration.Magnitude.Mean",
                               "timeDomain.BodyAcceleration.LinearAcceleration.Jerk.Magnitude.Mean",
                               "timeDomain.BodyAcceleration.Gyroscope.Magnitude.Mean",
                               "timeDomain.BodyAcceleration.Gyroscope.Jerk.Magnitude.Mean",
                               "freqDomain.BodyAcceleration.X.Mean",
                               "freqDomain.BodyAcceleration.Y.Mean",
                               "freqDomain.BodyAcceleration.Z.Mean",
                               "freqDomain.BodyAcceleration.LinearAcceleration.Jerk.X.Mean",
                               "freqDomain.BodyAcceleration.LinearAcceleration.Jerk.Y.Mean",
                               "freqDomain.BodyAcceleration.LinearAcceleration.Jerk.Z.Mean",
                               "freqDomain.BodyAcceleration.Gyroscope.X.Mean",
                               "freqDomain.BodyAcceleration.Gyroscope.Y.Mean",
                               "freqDomain.BodyAcceleration.Gyroscope.Z.Mean",
                               "freqDomain.BodyAcceleration.Magnitude.Mean",
                               "freqDomain.BodyAcceleration.LinearAcceleration.Jerk.Magnitude.Mean",
                               "freqDomain.BodyAcceleration.Gyroscope.Magnitude.Mean",
                               "freqDomain.BodyAcceleration.Gyroscope.Jerk.Magnitude.Mean")

# Use descriptive activity names to name the activities in the data set by merging the appropriate columns.
all_data <- merge(all_data, activity_names, by.x = "ActivitylabelID", by.y = "Num", all = TRUE)

# Remove the activity label id column, this is now just redundant information since we have the descriptive names.
all_data$ActivitylabelID <- NULL

# Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
melted <- melt(all_data, id.vars = c("SubjectIdentifier", "ActivityLabel"), variable.name = "V")
result <- dcast(melted, SubjectIdentifier + ActivityLabel ~ V, mean)

write.table(result,file = "submission.txt")