## Functions

# Anonymous functions

df <- data.frame(first = 5:9, second = (0:4)^2, third = -1:3)

# Calculate the root mean square for each column in a data.frame:

apply( df, 2, function(x) { sqrt(sum(x^2)) })
#     first    second    third
# 15.968719 18.814888 3.872983

# This function takes as input a vector (vec in this example) and outputs the same vector with the 
# vector's length (6 in this case) subtracted from each of the vector's elements:

vec <- 4:9

subtract.length <- function(x) { x - length(x) }

subtract.length(vec)   # returns -2 -1 0 1 2 3

# The below function is a more complicated example which calls another function and returns a data frame:

vec2 <- (4:7)/2

msdf <- function(x, multiplier=4) {
  mult <- x * multiplier
  subl <- subtract.length(x)
  data.frame(mult, subl)
}

msdf(vec2, 5)
#   mult subl
# 1 10.0 -2.0
# 2 12.5 -1.5
# 3 15.0 -1.0
# 4 17.5 -0.5

# Apply Functions

# apply: Applies a function to the rows or columns of a matrix (and higher-dimensional analogues). It's not 
# advisable to use it for data frames as it will coerce to a matrix first.

matrix <- matrix(seq(1,16), 4, 4)

matrix
#      [,1] [,2] [,3] [,4]
# [1,]    1    5    9   13
# [2,]    2    6   10   14
# [3,]    3    7   11   15
# [4,]    4    8   12   16

apply(matrix, 1, min)        # applies the min functions to all of the rows and returns [1] 1 2 3 4

apply(matrix, 2, max)        # applies the max functions to all of the rows and returns [1]  4  8 12 16

# lapply: Applies a function to each element of a list and returns a list containing the results.

list <- list(first = 1, second = 1:5, third = c(1,3,5)) 

lapply(list, FUN = sum) 
# $first
# [1] 1
# 
# $second
# [1] 15
# 
# $third
# [1] 9

# sapply: Applies a function to each element of a list and returns a vector containing the results.

sapply(list, FUN = sum)
# first second  third 
#     1     15      9 

sapply(list, FUN = length)
# first second  third 
#     1      5      3

