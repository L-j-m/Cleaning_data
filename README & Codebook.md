  The code is to generate a tidy data set for this project. \
  In the preperation stage, the original data file is downloaded and input as a dataframe. \
  After the required dataset has been input, they are combined together by rbind() and cbind() functions. \
  According to the questions, the required columns are the average and standard deviation of recording data. Therefore, by using contains() variable in select() function, the "mean" and "std" column can be extracted from the original data set. \
  After that, the code of activities are replaced by the exact names of activites, and the names of each column has been corrected by using gsub() function. \
  Finally, the average value of each column of data of each activity in each group has been generated by using group_by() function and summarise_all function. And a tidy data set has been generated.
