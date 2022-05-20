################################################################################
#                                                                              #
#   Specialization: Data Science - Foundations using R Specialization          #
#           Course: R Programming                                              #
#                                                                              #
#           Author: Anderson Hitoshi Uyekita                                   #
#             Date: 2022/05/13                                                 #
#                                                                              #
#          Project: Programming Assignment 1 - Air Pollution (Week 2)          #
#      Deliverable: best.R                                                     #
#                                                                              #
################################################################################

#' best Function
#' 
#' This function will find the best hospital in the last 30-day concerning a
#' specific outcome (heart attack, heart failure, or pneumonia)
#' 
#' @param state It is two letters representing one of the US's states, districts, or territories.
#' 
#' @param outcome It could be a heart attack, heart failure, or pneumonia.
#' 
#' Function to solve Part 2 of this programming assignment 1.
best <- function(state, outcome) {
    
    ## Read outcome data
    data_outcome <- utils::read.csv(file = "./data/outcome-of-care-measures.csv", 
                                    colClasses = "character")
    
    # Create a unique list of STATE in this dataset.
    # IMPORTANT: There are 54 states, which is wrong.
    # However, I found out this dataset contains DC and other territories.
    states_outcome <- base::unique(data_outcome$State)
    
    # List of outcomes
    list_disease <- c("heart attack", "heart failure", "pneumonia")
    
    ## Check that state and outcome are valid
    
    # Valid STATE and Valid OUTCOME
    if ((state %in% states_outcome) & (outcome %in% list_disease)) {
        # Subsetting the raw data.
        data_tidy <- data_outcome %>% select(Hospital.Name, State, starts_with("Hospital.30.Day.Death"))
        
        # Renaming columns to be readable.
        colnames(data_tidy) <- c("hospital_name", "hospital_state","heart_attack", "heart_failure", "pneumonia")
        
        # Uniforming the names with underscore to match during the select.
        outcome_ <- sub(pattern = " ", replacement = "_", x = outcome)
        
        # Converting character into numeric.
        data_tidy$heart_attack <- as.numeric(data_tidy$heart_attack)
        data_tidy$heart_failure <- as.numeric(data_tidy$heart_failure)
        data_tidy$pneumonia <- as.numeric(data_tidy$pneumonia)
        
        # Subsetting the Tidy Dataset to provide the output
        data_tidy %>%
            
            select(hospital_name,               #
                   hospital_state,              # Select only three variables to show in the output.
                   all_of(outcome_)) %>%        #
            
            filter(hospital_state == state) %>% # Filtering the dataset according to the state input.
            
            na.omit() %>%                       # Remove all rows with NA observations.
            
            select(-hospital_state) %>%         # Based on the examples, the output do not need to show state column
            
            arrange(across(all_of(outcome_)),   # I have arranged the dataset first by the outcome and then by hospital name.
                    hospital_name) %>%          # The result is a dataset with the best hospital in the first row.
            
            head(1) %>%                         # Selecting only the first rows (the best hospital in that outcome)
            
            select(hospital_name) %>%           # Selecting only the column.
            
            as.character() -> message           # Converting into a string to be equal to the example.
    }
    
    # Something is wrong with the inputs
    # The state input in not a valid one
    if (!(state %in% states_outcome) & (outcome %in% list_disease)) {
        return(base::cat(base::sprintf('Error in best("%s", "%s") : invalid state', state, outcome)))
    }
    
    # The outcome in not valid.
    if ((state %in% states_outcome) & !(outcome %in% list_disease)) {
        return(base::cat(base::sprintf('Error in best("%s", "%s") : invalid outcome', state, outcome)))
    }
    
    # Both state and outcome has typos
    if (!(state %in% states_outcome) & !(outcome %in% list_disease)) {
        return(base::cat(base::sprintf('Error in best("%s", "%s") : invalid state and outcome', state, outcome)))
    }
    
    ## Return hospital name in that state with lowest 30-day death
    
    ## rate
    return(message)
}
