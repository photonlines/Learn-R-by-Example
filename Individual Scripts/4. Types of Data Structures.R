## Types of Data Structures

# There are no scalar data types in R. Vectors of length-one act like scalars.

# There are 4 main data structures:

# 1. Vectors: Atomic vectors must be sequence of same-class objects: a sequence of numbers, a sequence of
#    logicals, or a sequence of characters. Vectors are usually created with c(), short for combine:

vec <- c(1, 4.5, 8.5, 10)

# 2. Matrices: A matrix of numbers, logicals or characters. Matrices are vectors with a dimension attribute. The 
#    dimension attribute is itself an integer vector of length 2 (number of rows, number of columns).

matr <- matrix(1:6, ncol = 3, nrow = 2)

# 3. Lists: A special type of vector that can contain elements of different classes. 

lst <- list(4:8, "g", c(FALSE, FALSE, TRUE), c(1.5, 8.8))

# 4. Data Frames: Data frames are represented as a special type of list where every element of the list has to 
#    have the same length. Each element of the list can be thought of as a column and the length of each element
#    of the list is the number of rows. Unlike matrices, data frames can store different classes of objects in 
#    each column. 

df <- data.frame( x = 1:3, y = c("str1", "str1", "str3"))

