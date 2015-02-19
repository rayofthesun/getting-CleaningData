# getting-CleaningData
### Files Included:
This repo contains files- run_Analysis.R, README, and a codeBook.

###README.md
  This file contains the description of different files and the approach used for solving the project.
#### codeBook : 
codebook describes the final tidy data set that is generated. It describes the column names and the class of these columns

#### run_Analysys.R
This file contains the function for performing the necessary operations on the original data that is provided


### Explanation of the Work:
### STEP 1:
1. All the relevant files are read using read.csv into separate data frames
2. The training and testing data are read into Data Frames and then row binded (for X_ Y_ , and subject related files separtely). 
2. Then, I selected column names from features data frame, and used them to name the columns of already binded data set.

### STEP 2: 
3. After that, using grep, columns related to mean and standard deviation are selected.

### STEP 3: 
4. Activity and subject related data frames are column binded to the resultant data frame 

### STEP 4:

5. Now, for getting the activity names, the previous data frame is "merged" with the data containing activity names

### STEP 5:
6. Independent tidy data set is obtained from the data set in step 4, by averaging each activity and each subject. For this, group_by and summarise_each functions are used.


