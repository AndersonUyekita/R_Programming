################################################################################
#                                                                              #
#   Specialization: Data Science - Foundations using R Specialization          #
#   Course: R Programming                                                      #
#                                                                              #
#   Author: Anderson Hitoshi Uyekita                                           #
#   Date: 2022/05/16                                                           #
#   Project: Programming Assignment 2 - Lexical Scoping (Week 3)               #
#                                                                              #
################################################################################

#' makeCacheMatrix Function
#' 
#' Given the example function from the statement. I have made some minor changes
#' to adapt it to calculate the inverse of a Matrix.
#' 
#' @param x Should be a any invertible matrix
#' 
#' @examples
#'
#' \dontrun{
#' # Make it reproducible examples defining a fixed seed.
#' base::set.seed(2022)
#' 
#' # Create a "toy" matrix.
#' A <- matrix(rnorm(9, 0, 1), nrow = 3)
#' 
#' # Cacheable Matrix A
#' A_cache <- makeCacheMatrix(x = A)
#' }
#'
#' @export
makeCacheMatrix <- function(x = matrix()) {
    
    # I have changed the variable name to "m_inverse" to make an allusion to matrix inverse.
    # Variable initialization as NULL means I do not have this inverse matrix on my cache.
    m_inverse <- NULL
    
    # Inner function SET
    # Update the Matrix stored in the Cacheable variable.
    set <- function(y) {
        x <<- y
        m_inverse <<- NULL
    }
    
    # Inner function GET
    # Retrieve the original Matrix (not the inverse one).
    # Example: A_cache$get()
    get <- function() {
        x
    }
    
    # Inner function SETSOLVE
    # CALCULATE the inverse matrix.
    # Example: A_cache$setsolve()
    setsolve <- function(solve) {
        m_inverse <<- solve
    }
    
    # Inner function GETSOLVE
    # GET the inverse matrix stored in cache.
    # Example: A_cache$getsolve()
    getsolve <- function() {
        m_inverse
    }
    
    # Return a list of functions defined above.
    # These function will be used by cacheSolve function.
    list(set = set, get = get, setsolve = setsolve, getsolve = getsolve)
}

#' cacheSolve function
#'
#' This function computes the inverse of the special "matrix"
#'
#' @param x Should be a cacheable matrix (see the results of makeCacheMatrix function)
#' 
#' @examples
#' 
#' \dontrun{
#' # Make it reproducible
#' base::set.seed(2022)
#' 
#' # Create a "toy" matrix.
#' A <- matrix(rnorm(9, 0, 1), nrow = 3)
#' 
#' # Cacheable Matrix A
#' A_cache <- makeCacheMatrix(x = A)
#' 
#' # Calculate the inverse of A_cache
#' A_cache_inverse <- cacheSolve(x = A_cache)
#' 
#' # Compare the regular function solve with it.
#' base::identical(base::solve(A), A_cache_inverse)
#' 
#' # TRUE means the both methods ends into the inverse matrix.
#' }
#' 
#' @export
cacheSolve <- function(x, ...) {
    
    # Use of GETSOLVE inner function.
    # It should be NULL for the first time you will calculate it because we have defined it as NULL.
    m_inverse <- x$getsolve()
    
    # CASE A: m_inverse is not NULL, they will skip the inverting process and will take the data from cache.
    if(!is.null(m_inverse)) {
        message("getting cached data")
        
        # Matrix stored in the cache.
        return(m_inverse)
    }
    
    # CASE B: The m_inverse matrix is NULL, which means there is no data about this inverse matrix.
    
    # Store the Matrix in a "temporally" variable
    data <- x$get()
    
    # Calculate the inverse using the Base package solve function.
    m_inverse <- base::solve(data, ...)
    
    # Store the inverse matrix in the Cacheable variable.
    x$setsolve(m_inverse)
    
    # Return the inverse matrix
    m_inverse 
}

# READINGS: http://adv-r.had.co.nz/Functional-programming.html#closures