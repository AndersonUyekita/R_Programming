################################################################################
#                                                                              #
#   Specialization: Data Science - Foundations using R Specialization          #
#           Course: R Programming                                              #
#                                                                              #
#           Author: Anderson Hitoshi Uyekita                                   #
#             Date: 2022/05/13                                                 #
#                                                                              #
#          Project: Programming Assignment 1 - Air Pollution (Week 2)          #
#      Deliverable: complete.R                                                 #
#                                                                              #
################################################################################

#' complete Function
#' 
#' This function counts the number of valid observations of a specific pollutant.
#' 
#' @param directory The folder where the monitor's files are stored.
#' 
#' @param id It could be a single monitor's id or a vector containing several monitor ids.
#' 
# Function to solve the Part 2.
# This function calculate the number of validy observation from each monitor file.
complete <- function(directory, id) {
    # directory: Folder with all monitor's data
    # id: Varies from 1 to 332
    
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
            # Read a single monitor
            df_raw <- read_data(monitor_id = id, directory = directory, path = "R Programming")
            
            # Select only complete rows (without any NA)
            df_tidy <- stats::na.omit(df_raw)   # This function (na.omit) is way better
            # It has the same result of:
            # df_raw[!is.na(df_raw$sulfate) & !is.na(df_raw$nitrate),]
            
            # Count the number of complety rows
            nobs <- base::nrow(df_tidy)
            
            # Return the dataframe with columns: ID and nobs
            return(data.frame(id,nobs))
        }
    }
    
    # Multiple monitor analysis.
    else {
        # It tracks an id out of the boundaries of 1 and 322.
        # If the operator selects one or more ID out of the boundaries the sum should be greater than zero
        if (base::sum(id > 332 | id <= 0) > 0) {
            # Message to the operator.
            return(base::print("Please, check your input to ID. Should be between 1 and 322."))
        }
        
        # All other acceptable conditions with multiple monitors analysis.
        if (base::length(id) > 1 & base::length(id) <= base::length(base::list.files(path = "R Programming/specdata"))) {
            # Data Frame initialization.
            df_raw <- data.frame()
            nobs <- base::vector()
            
            # Loop to create a dataset with all data of monitors from id.
            for (i in id) {
                # Stack two dataframes to create a bigger one.
                df_raw <- read_data(monitor_id = i,          #
                                    directory = directory,   # Inner function to read the monitor file.
                                    path = "R Programming")
                
                # Select only complete rows (without any NA)
                df_tidy <- stats::na.omit(df_raw)   # This function (na.omit) is way better
                # It has the same result of:
                # df_raw[!is.na(df_raw$sulfate) & !is.na(df_raw$nitrate),]
                
                # Count the number of complety rows
                nobs <- base::append(nobs, base::nrow(df_tidy))
                
            }
            # Return the dataframe with columns: ID and nobs
            return(data.frame(id,nobs))
        }
    }
}