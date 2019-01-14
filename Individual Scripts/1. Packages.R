## Packages

# Example of how to download the the 'stringi' package from CRAN and load it:

install.packages('stringi') 
require(stringi)

# You can also use the library fuction to load and attach add-on packages.

library(stringi)

installed.packages()

# We'll create a function which takes a list of packages as input and checks if the packages are 
# installed. If not, the function installs the package and loads it into the R session.

install_and_load_package <- function(packages) {
  
  missing_packages <- packages[!(packages %in% installed.packages()[, "Package"])]
  
  if (length(missing_packages)) 
    install.packages(missing_packages, dependencies = TRUE)
  
  # Load all of the packages by applying the require function to each item 
  sapply(packages, require, character.only = TRUE)
  
}

# Lets try loading a few packages. 

install_and_load_package('rvest')

packages_to_load <- c("ggplot2", "reshape2")

install_and_load_package( packages_to_load )

install_and_load_package( c('randomForest', 'xgboost', 'Rcpp') )

