## Differences in Subsetting Syntax

# A data.table is one of several two-dimensional data structures available in R, besides data.frame, matrix and (2D)
# array. All of these classes use a very similar but not identical syntax for subsetting, the A[rows, cols] schema.

# Consider the following data stored in a matrix, a data.frame and a data.table:
  
matrix <- matrix(1:12, nrow=4, dimnames=list(letters[1:4], c('X', 'Y', 'Z')))

matrix
#   X Y  Z
# a 1 5  9
# b 2 6 10
# c 3 7 11
# d 4 8 12

data_frame <- as.data.frame(matrix)
data_table <- as.data.table(matrix)

matrix[2:3]       # returns 2 3, the 2nd and 3rd items, as if matrix were a vector (because it is!)

data_frame[2:3]   # returns the 2nd and 3rd columns
#   Y  Z
# a 5  9
# b 6 10
# c 7 11
# d 8 12

data_table[2:3]   # returns the 2nd and 3rd rows!
#    X Y  Z
# 1: 2 6 10
# 2: 3 7 11

# If you want to be sure of what will be returned, it is better to be explicit.
# To get specific rows, just add a comma after the range:
  
matrix[2:3, ]     # returns the 2nd and 3rd rows
data_frame[2:3, ] # returns the 2nd and 3rd rows
data_table[2:3, ] # returns the 2nd and 3rd rows

# But, if you want to subset columns, some cases are interpreted differently. All three can be subset the same way
# with integer or character indices not stored in a variable.

matrix[, 2:3]              # returns the 2nd and 3rd columns
data_frame[, 2:3]          # returns the 2nd and 3rd columns
data_table[, 2:3]          # returns the 2nd and 3rd columns
matrix[, c("Y", "Z")]      # returns the 2nd and 3rd columns
data_frame[, c("Y", "Z")]  # returns the 2nd and 3rd columns
data_table[, c("Y", "Z")]  # returns the 2nd and 3rd columns

# The setkey() function sorts a data.table and marks it as sorted. The sorted columns are the key. The key can be any 
# columns in any order. The columns are always sorted in ascending order. The table is changed by reference, which 
# means that the entire table isn't copied and re-arranged. The rows are just swapped.

# Setting keys in data.table:

setkey(data_table, Y)

# Setting secondary indices:

# Indexing is a way of sorting a number of records on multiple fields. Creating an index on a field in a table creates 
# another data structure which holds the field value, and a pointer to the record it relates to. This index structure 
# is then sorted, allowing efficient binary searches to be performed on it. The downside of this is that more memory 
# is needed to hold the extra indexing data, although more efficient searches can be performed.

# In a manner similar to key, you can setindex(DT, key.col) or setindexv(DT, "key.col.string"), where DT is
# your data.table. Remove all indices with setindex(DT, NULL).

# Let us set x as index:

setindex(data_table, X)

# There are many reasons to write code that is guaranteed to work with data.frame and data.table. Maybe you are
# forced to use data.frame, or you may need to share some code that you don't know how will be used. So, there are
# some main strategies for achieving this, in order of convenience:

# 1. Use syntax that behaves the same for both classes.
# 2. Use a common function that does the same thing as the shortest syntax.
# 3. Force data.table to behave as data.frame (ex.: call the specific method print.data.frame).
# 4. Treat them as list, which they ultimately are.
# 5. Convert the table to a data.frame before doing anything (bad idea if it is a huge table).
# 6. Convert the table to data.table, if dependencies are not a concern.

