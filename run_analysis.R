############################################################

# Part 1
# Merges the training and the test sets to create one data set.

# import data from zip
test_subject <- read.table("UCI HAR Dataset/test/subject_test.txt")
test_x <- read.table("UCI HAR Dataset/test/X_test.txt")
test_y <- read.table("UCI HAR Dataset/test/y_test.txt")

train_subject <- read.table("UCI HAR Dataset/train/subject_train.txt")
train_x <- read.table("UCI HAR Dataset/train/X_train.txt")
train_y <- read.table("UCI HAR Dataset/train/y_train.txt")

# change names of columns
colnames(test_subject)[1] <- "subject"
colnames(train_subject)[1] <- "subject"
colnames(test_y)[1] <- "activity"
colnames(train_y)[1] <- "activity"

# bind columns together
test_all <- cbind(test_subject, test_y, test_x)
train_all <- cbind(train_subject, train_y, train_x)

# bind rows together
all <- rbind(test_all, train_all)


############################################################

# Part 2
# Extracts only the measurements on the mean and standard
# deviation for each measurement. 

# read in features.txt
features <- read.table("UCI HAR Dataset/features.txt")

# add column which concatenates "V" + number from V1 column
# Needed later to match with "all" dataframe
features$V3 <- paste ("V", as.character(features$V1), sep="")

# get row numbers that include "mean", "std", or "Mean"
# NOTE it is not clear in the exercise what is meant. Maybe should only extract
# "mean()" and "std()". I've included more data so it will be easier to extract
# later if necessary.
string_vector <- c("mean", "std", "Mean")
features2 <- features[grep(paste(string_vector, collapse="|"), features$V2), ]

# Create a vector of columns to keep - subject, activity and those columns that have mean or std
cols_to_keep <- c("subject", "activity", features2$V3)

# extract only mean and std columns from all
mean_std <- all[ , cols_to_keep]


############################################################

# Part 3
# Uses descriptive activity names to name the activities in the data set

# substitute numbers in activity for description from activity_labels.txt
mean_std$activity <- gsub("1", "Walking", mean_std$activity)
mean_std$activity <- gsub("2", "Walking_upstairs", mean_std$activity)
mean_std$activity <- gsub("3", "Walking_downstairs", mean_std$activity)
mean_std$activity <- gsub("4", "Sitting", mean_std$activity)
mean_std$activity <- gsub("5", "Standing", mean_std$activity)
mean_std$activity <- gsub("6", "Laying", mean_std$activity)


############################################################

# Part 4
# Appropriately labels the data set with descriptive variable names. 

# add column to features2 to create name 
# removing any special characters "()-,"
features2$V4 <- gsub("[[:punct:]]", "", features2$V2)

# set names in features2$V4 as name of columns in mean_std
# test are identical before changing names
identical (names(mean_std), c("subject", "activity", features2$V3) )
# returns TRUE - so OK to continue

# change columns names
new_col_names <- c("subject", "activity", features2$V4)
colnames(mean_std) <- c("subject", "activity", features2$V4)


############################################################

# Part 5
# Creates a second, independent tidy data set with the
# average of each variable for each activity and each subject. 

# find mean of each subject for a specific activity
# eg average of subject 22 walking
# max number of rows 30 (subjects) x 6 (rows)

tidy_dataset <- aggregate( . ~ subject + activity, data = mean_std, FUN=mean)

# export to .txt
write.table(tidy_dataset, file="tidy_dataset.txt",  row.names=FALSE)

