# Code Book

Field | Type  | Description
----- | ----- | --------
activity | string | Activity performed by subject. One of WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING.
subject | integer | Subject Id of the person who performed the activity. A value between 1 and 30.
tBodyAccMagMean | numeric |  See Note below.
tBodyAccMagStdDev | numeric | See Note below.
tGravityAccMagMean | numeric | See Note below.
tGravityAccMagStdDev | numeric | See Note below.
tBodyAccJerkMagMean | numeric |See Note below.
tBodyAccJerkMagStdDev |numeric |See Note below.
tBodyGyroMagMean | numeric|See Note below.
tBodyGyroMagStdDev | numeric|See Note below.
tBodyGyroJerkMagMean | numeric| See Note below.
tBodyGyroJerkMagStdDev | numeric|See Note below.
fBodyAccMagMean |numeric |See Note below.
fBodyAccMagStdDev | numeric|See Note below.
fBodyBodyAccJerkMagMean | numeric|See Note below.
fBodyBodyAccJerkMagStdDev | numeric|See Note below.
fBodyBodyGyroMagMean | numeric|See Note below.
fBodyBodyGyroMagStdDev | numeric|See Note below.
fBodyBodyGyroJerkMagMean | numeric|See Note below.
fBodyBodyGyroJerkMagStdDev | numeric|See Note below.

Note: 

Field names starting with t (e.g. tBodyAccMagMean) are time domain samples of original dataset that were summarised (using mean) by activity and subject.

Field names starting with f (e.g. fBodyAccMagMean) are frequency domain samples of original dataset that were summarised (using mean) by activity and subject.


