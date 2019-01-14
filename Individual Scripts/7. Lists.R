## Lists

# Lists are a special type of vector where each element can be anything, even another list.

list_example <- list(   A = c(5,6,7,8)
                      , B = letters[1:6]
                      , CC = list( 5, "Z") 
                    )

example_list <- list (course = 'stat'
                    , date = '04/07/2009'
                    , num_isc = 7
                    , num_cons = 6
                    , num_mat = as.character(c(45020, 45679, 46789, 43126, 42345, 47568, 45674))
                    , results = c(30, 19, 29, NA, 25, 26 ,27) 
                  )

# Extracting elements from a list can be done by name (if the list is named) or by index:

example_list$date   # returns the date element "04/07/2009"
example_list[1]     # returns the 1st element "stat"

# Lists have two very important uses:

# 1) Since functions can only return a single value, it is common to return complicated results in a list.
# 2) Lists are also the underlying fundamental class for data frames. Under the hood, a data frame is a list of
#    vectors all having the same length.

# Using a list to return function results:

example_function <- function(x) list( xplus = x + 10, xsq = x ^ 2 )

results = example_function (7)

results$xplus    # returns 17
results$xsq      # returns 49

# Using a list to create a data frame:

list1 <- list(x = 1:2, y = c("A","B"))

data_frame1 <- data.frame(list1)

data_frame1
#   x y
# 1 1 A
# 2 2 B

is.list(data_frame1)  # returns  TRUE

