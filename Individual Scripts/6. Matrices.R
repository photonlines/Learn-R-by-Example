## Matrices 

# Like vectors, matrices must be made of same-class elements.

# Under the hood, a matrix is a special kind of vector with two dimensions. You can create matrices using the 
# matrix function as shown below:

matrix(data = 1:6, nrow = 2, ncol = 3)
# [,1] [,2] [,3]
# [1,] 1 3 5
# [2,] 2 4 6

matrix2 <- matrix( data = c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12), nrow = 4, ncol = 3, byrow = F)

matrix2
#       [,1] [,2] [,3]
# [1,]    1    5    9
# [2,]    2    6   10
# [3,]    3    7   11
# [4,]    4    8   12

matrix2[1, 1]  # returns 1, the first entry of our matrix.
matrix2[1, 2]  # returns 5, the element on the first row, second column.
matrix2[4, 3]  # returns 12, the last element of our matrix (fourth row, third column).

# The rows and columns of a matrix can have names. You can look at these using the functions rownames and colnames. 
# As shown below, the rows and columns don't initially have names, and are denoted by NULL:

rownames(matrix2) # returns NULL
colnames(matrix2) # returns NULL

# However, you can assign values to them:

rownames(matrix2) <- c("Row 1", "Row 2", "Row 3", "Row 4")
colnames(matrix2) <- c("Col 1", "Col 2", "Col 3")

matrix2
#       Col 1 Col 2 Col 3
# Row 1     1     5     9
# Row 2     2     6    10
# Row 3     3     7    11
# Row 4     4     8    12

# The 'class', 'is', and 'as' functions can be used to check and coerce data structures:

class(matrix2)        # returns  "matrix"
is.matrix(matrix2)    # returns  TRUE
as.vector(matrix2)    # returns  1  2  3  4  5  6  7  8  9 10 11 12

# Matrix creation through cbind (column bind) function:

matrix1 <- cbind(1:4, 5:8, 9:12)

matrix1
#      [,1] [,2] [,3]
# [1,]    1    5    9
# [2,]    2    6   10
# [3,]    3    7   11
# [4,]    4    8   12

# Matrix creation through rbind (row bind) function.

matrix2 = rbind( c(1,5,9), c(2,6,10), c(3,7,11), c(4,8,12) )
#      [,1] [,2] [,3]
# [1,]    1    5    9
# [2,]    2    6   10
# [3,]    3    7   11
# [4,]    4    8   12

# Matrix + scalar example:
# R adds the scalar value to each entry in the matrix:

matrix1 + scalar1
#      [,1] [,2] [,3]
# [1,]    2    6   10
# [2,]    3    7   11
# [3,]    4    8   12
# [4,]    5    9   13

# Matrix + vector example:
# R does the operation in a column-wise manner:

matrix1 + vector1
#      [,1] [,2] [,3]
# [1,]    2    6   10
# [2,]    4    8   12
# [3,]    6   10   14
# [4,]    8   12   16

# Matrix + matrix example (it's always component wise):

matrix1 + matrix2
# [,1] [,2] [,3]
# [1,]    2   10   18
# [2,]    4   12   20
# [3,]    6   14   22
# [4,]    8   16   24

# Matrix standard product example (it's always component wise):

matrix1 * matrix2
# [,1] [,2] [,3]
# [1,]    1   25   81
# [2,]    4   36  100
# [3,]    9   49  121
# [4,]   16   64  144

