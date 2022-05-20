################################################################################
#                                                                              #
#   Specialization: Data Science - Foundations using R Specialization          #
#           Course: R Programming                                              #
#                                                                              #
#           Author: Anderson Hitoshi Uyekita                                   #
#             Date: 2022/05/13                                                 #
#                                                                              #
#          Project: Programming Assignment 1 - Air Pollution (Week 2)          #
#      Deliverable: corr.R                                                     #
#                                                                              #
################################################################################

#' corr Function
#' 
#' This function calculates the correlation between nitrate and sulfate.
#' 
#' @param directory The folder where the monitor's files are stored.
#' 
#' @param threshold The threshold is the minimum value at which the pollutant should be considered for the correlation calculation.
#' 
# Function to solve the Part 3.
# This function calculate the correlation between nitrate and sulfate from validy observations.
corr <- function(directory, threshold = 0) {
    
    # Calculate all nobs from all monitors
    table_nobs <- complete(directory, 1:332)
    
    # Filter the monitor within the threshold
    table_threshold <- table_nobs[table_nobs$nobs > threshold,]
    
    # Inner Function to ease the loading process
    read_data <- function(monitor_id, directory, path = "R Programming") {
        # monitor_id: The number of Monitor File
        # directory: default folder
        # path: The location where I have stored the files
        
        # Create the file name.
        # Should be like this: "R Programming/specdata/001.csv"
        file_name <- base::paste0(stringr::str_pad(string = monitor_id, #
                                                   width =  3,          # Creates the zeros on left
                                                   pad = "0"),          #                       00X
                                  ".csv")                               # Insert the file type.
        
        # Given the file_name and path, this will import the CSV file.
        df <- utils::read.csv(file = base::file.path(path,        # file.path should create a string to be used as path
                                                     directory,   # "./R Programming/specdata/00X.csv"
                                                     file_name))  # 
        
        # Return the data frame.
        return(df)
    }
    
    # Vector to store the Correlation. According to the statement must be NUMERIC.
    correlation <- vector(mode = "numeric")
    
    # Loop to calculate all ID within the threshold
    for (j in table_threshold$id) {
        # Create a dataset with no NA.
        df_tidy <- stats::na.omit(read_data(monitor_id = j, directory = directory, path = "R Programming"))
        
        # Adds the new corr data to the vector of correlation.
        correlation <- base::append(correlation, stats::cor(df_tidy$sulfate, df_tidy$nitrate))
        
    }
    
    # Insert a new column to the table_threshold. It will not be RETURNED but it is good to debug and general understanding.
    table_threshold['corr'] <- correlation
    
    # Return only the correlation of monitor within the threshold
    return(correlation)
}