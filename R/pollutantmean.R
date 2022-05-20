################################################################################
#                                                                              #
#   Specialization: Data Science - Foundations using R Specialization          #
#           Course: R Programming                                              #
#                                                                              #
#           Author: Anderson Hitoshi Uyekita                                   #
#             Date: 2022/05/13                                                 #
#                                                                              #
#          Project: Programming Assignment 1 - Air Pollution (Week 2)          #
#      Deliverable: pollutantmean.R                                            #
#                                                                              #
################################################################################

#' pollutantmean Function
#'
#' This function calculates the mean of a given pollutant, excluding the NA values.
#'
#' @param directory The folder where the monitor's files are stored.
#' 
#' @param pollutant The dataset has two kinds of pollutants. This variable should be sulfate or nitrate.
#' 
# Function to solve the Part 1.
# This function calculate sulfate/nitrate from monitor files.
pollutantmean <- function(directory, pollutant, id = 1:332) {
    # directory: Folder with all monitor's data
    # pollutant: nitrate or sulfate
    # id: Varies from 1 to 332
    
    # Inner Function to ease the loading process
    read_data <- function(monitor_id, directory, path = "R Programming") {
        # monitor_id: The number of Monitor File
        # directory: default folder
        # path: The location where I have stored the files
        
        # Create the file name and path.
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
    
    # Decision Tree.
    
    # Single monitor analysis.
    if (base::length(id) == 1) {
        # If the operator inserts a wrong number of monitor (negative number, zero or above of 322)
        if (id <= 0 | id > base::length(list.files(path = "R Programming/specdata"))) {
            # Message to the operator.
            return(base::print("Please, check your input to ID. Should be between 1 and 322."))
        }
        
        # All other aceptable conditions.
        else {
            df_raw <- read_data(monitor_id = id, directory = directory, path = "R Programming")
            # return the result of Inner Function to read the monitor files.
            return(base::mean(x = df_raw[[pollutant]], na.rm = TRUE))
        }
    }
    
    # Multiple monitor analysis.
    else {
        # It tracks an id out of the boundaries of 1 and 332.
        # If the operator selects one or more ID out of the boundaries the sum should be greater than zero
        if (base::sum(id > 332 | id <= 0) > 0) {
            # Message to the operator.
            return(base::print("Please, check your input to ID. Should be between 1 and 322."))
        }
        
        # All other acceptable conditions with multiple monitors analysis.
        if (base::length(id) > 1 & base::length(id) <= base::length(base::list.files(path = "R Programming/specdata"))) {
            # Data Frame initialization.
            df_raw <- data.frame()
            
            # Loop to create a dataset with all data of monitors from id.
            for (i in id) {
                # Stack two dataframes to create a bigger one.
                df_raw <- rbind(df_raw,
                                read_data(monitor_id = i,          #
                                          directory = directory,   # Inner function to read the monitor file.
                                          path = "R Programming")) #
            }
            # Return the result of the Inner Function to read the monitor files.
            return(base::mean(x = df_raw[[pollutant]], na.rm = TRUE))
        }
    }
}