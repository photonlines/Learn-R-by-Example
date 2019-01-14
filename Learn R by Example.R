# This R script gives an overview of the R language. Most of the examples are taken from the R Notes for 
# Professionals book available here: https://books.goalkicker.com/RBook/
# The R Notes for Professionals book is compiled from Stack Overflow Documentation and the content was written 
# by Stack Overflow users. The book content is released under Creative Commons BY-SA license.

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

## Variables

# In R, variables are assigned values using the infix-assignment operator <-. The operator = can also be used for
# assigning values to variables, however, its proper use is for associating values with parameter names in function
# calls.

variable1 <- 22
variable2 = 23

# It is also possible to make assignments to variables using ->.

3 -> x

# Private Variables:

# A leading dot in a name of a variable or function in R is commonly used to denote that the variable or function is
# meant to be hidden.

.private_variable <- 'private' 

.private_variable
# [1] "private"

# The ls function which lists the objects will not include the private variable:

ls()   # returns a list which doesn't include 'private_variable'

## R Scalars

# Some simple examples of declaring and using scalars:

scalar1 <- 1
scalar2 <- 2

scalar1 + scalar2    # returns  3

# Numeric classes and storage modes

# Doubles are R's default numeric value. They are double precision vectors, meaning that they take up 8 bytes of
# memory for each value in the vector. 

# Integers are represented by a number with an L after it. Any number without an L after it will be considered a 
# double.

is.double( 1 )     # returns TRUE
is.double( 1.0 )   # returns TRUE
is.double( 1L )    # returns FALSE

# Numeric represents integers and doubles and is the default mode assigned to vectors of numbers. The function
# is.numeric() will determine if a vector is numeric. It is important to note that although integers and doubles
# will pass is.numeric(), the function as.numeric() will always attempt to convert to type double.

x <- 12.3
y <- 12L

typeof(x)    # returns "double"
typeof(y)    # returns "integer"

# Logical to numeric conversion

as.numeric(TRUE)                # returns 1

# While TRUE == 1, it is a double and not an integer

is.integer(as.numeric(TRUE))    # returns FALSE

# The logical class

# ! Not !x

!TRUE     # returns  FALSE

# The || operator evaluates the left condition and if the left condition is TRUE the right side is never evaluated: 

7 > 6 || stop ( "X is too small" )       # returns TRUE

7 > 6 | stop ( "X is too small" )        # returns Error: X is too small

# The && operator will likewise return FALSE without evaluation of the second argument when the first element 
# of the first argument is FALSE:

7 <= 6 && stop ( "X is too small" )      # returns FALSE

7 <= 6 & stop ( "X is too small" )       # returns Error: X is too small

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

## Vectors

# Atomic vectors must be sequence of same-class objects.

vector <- c(2, 3, 7, 10)
vector2 <- c("a", "b", "c")

vector[1]    # returns 1, the first element
vector[4]    # returns 10, our last element

vector1 <- c(1,2,3,4)
vector2 <- c(2,3,4,5)

vector1 + vector2    # returns  3 5 7 9

vector1 + scalar1    # returns  2 3 4 5

vector1 ^ 2          # returns  1  4  9 16

# Some vector functions:

# Length outputs the number of elements in the vector:

vector1 <- 1:4

length(vector1)  # returns:  4

# Sum adds all of the elements of a vector:

sum(vector1)  # returns:  10

# Adding vectors of different lengths: Shorter vectors in the expression are recycled as often as need be
# until they match the length of the longest vector. In particular a constant is simply repeated. In the below
# example, vector1's first element is recycled since its length is less than that of vector2:

vector2 = 1:5

vector1 + vector2   # returns  2 4 6 8 6 (with a warning message)

# The Character Class

# Characters are what other languages call 'string vectors.'

x <- "The quick brown fox jumps over the lazy dog"

class(x)          # returns  "character"

# String Manipulation

# Count pattern inside string:

stri_count_fixed("babab", "b")     # returns  3
stri_count_fixed("babab", "ba")    # returns  2

# With regex

stri_count_regex("a1 b2 a3 b4 aa", "a.")   # returns  3
stri_count_regex("a1 b2 a3 b4 aa", "a\\d") # returns  2

# Duplicating strings

stri_dup("abc", 3)  # returns  "abcabcabc"

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

## Data Frames

# A data.frame is a special kind of list: it is rectangular. Each element (column) of the list has the same length, 
# and each row has a "row name". Each column has its own class, but the class of one column can be different 
# from the class of another column (unlike a matrix, where all elements must have the same class).

example_frame <- data.frame(  matr = as.character(c(45020, 45679, 46789, 43126, 42345, 47568, 45674))
                   , res_S = c(30, 19, 29, NA, 25, 26, 27)
                   , res_O = c(3, 3, 1, NA, 3, 2, NA) 
                )

example_frame
#    matr res_S res_O
# 1 45020    30     3
# 2 45679    19     3
# 3 46789    29     1
# 4 43126    NA    NA
# 5 42345    25     3
# 6 47568    26     2
# 7 45674    27    NA

# Subsetting rows and columns from a data frame

# We can access elements of a data frame using matrix notation (with single brackets data[rows, columns]):

example_frame[1, 1]       # returns 45020

# Get the first row:

example_frame[1, ]        # returns 45020    30     3

# Get the first 2 rows:

example_frame[1:2, ]
#    matr res_S res_O
# 1 45020    30     3
# 2 45679    19     3

# Get the first column:

example_frame[, 1]        # returns 45020 45679 46789 43126 42345 47568 45674

# Get the res_O column:

example_frame$res_O        # returns 3  3  1 NA  3  2 NA

# Get the res_S column:

example_frame[, 'res_S']   # returns 30 19 29 NA 25 26 27

# Get the first and third columns:

example_frame[, c(1, 3)]
#    matr res_O
# 1 45020     3
# 2 45679     3
# 3 46789     1
# 4 43126    NA
# 5 42345     3
# 6 47568     2
# 7 45674    NA

# Get the first 4 rows of the res_S and res_O columns:

example_frame[1:4, c("res_S", "res_O")]
#   res_S res_O
# 1    30     3
# 2    19     3
# 3    29     1
# 4    NA    NA

# If you extract multiple columns, you will get a data frame back. However, if you extract a single column, you 
# will get a vector, not a data frame under the default options.

# Multiple columns return a data frame:

class(mtcars[, c("mpg", "cyl")])    # returns "data.frame"

# Single column returns a vector:

class(mtcars[, "mpg"])              # returns "numeric"

# When you use single brackets and no commas, you will get column back because data frames are lists of columns.

class(mtcars["mpg"])                # returns "data.frame"

mtcars[c("mpg", "cyl", "disp")]     # returns a data frame containing columns "mpg", "cyl", "disp":

# To extract a single column as a vector when treating your data.frame as a list, you can use double brackets [[.
# This will only work for a single column at a time.

# Extract a single column by name as a vector:

mtcars[["mpg"]]

# A single column can be extracted using the magical shortcut $ without using a quoted column name. 
# Columns accessed by $ will always be vectors, not data frames.

mtcars$mpg  # returns the column "mpg" as a vector:

# Logical vectors indicate specific elements to keep. We can use a condition such as < to generate a logical vector,
# and extract only the rows that meet the condition.

mtcars[mtcars$mpg < 15, ]  # returns all cars which have miles per galon (mpg) less than 15

mtcars[mtcars$cyl == 4, ]  # returns all columns for rows where the value of cyl is 4

mtcars[mtcars$cyl == 4, c("cyl", "mpg", "hp")]  # returns the cyl, mpg, and hp columns where the value of cyl is 4

# Convenience functions to manipulate data.frames

# The subset() function allows you to subset a data.frame in a more convenient way (subset also works with other
# classes):

# Return the lines for which cyl == 6 and for the columns mpg and hp:

subset(mtcars, subset = cyl == 6, select = c("mpg", "hp"))  

# Same as: 

mtcars[mtcars$cyl == 6, c("mpg", "hp")]

# The transform() function is a convenience function to change columns inside a data.frame.

# The below example adds another column named mpg2 with the result of mpg^2 to the mtcars data.frame:

mtcars <- transform(mtcars, mpg2 = mpg^2)

# Both with() and within() let you to evaluate expressions inside the data.frame environment

# The below example shows how to create, change and/or remove multiple columns in the airquality data.frame:

aq <- within(airquality, {
  lOzone <- log(Ozone)                  # creates new lOzone column
  Month <- factor(month.abb[Month])     # changes new Month column
  cTemp <- round((Temp - 32) * 5/9, 1)  # creates new cTemp column
  S.cT <- Solar.R / cTemp               # creates new S.cT column
  rm(Day, Temp)                         # removes Day and Temp columns
})

# It is important to note that, by default, data frames coerce characters to factors.

# The default behavior can be changed with the stringsAsFactors parameter. Example:

df3 <- data.frame(x = 1:3, y = c("a", "b", "c"), stringsAsFactors = FALSE)

# If the data has already been created, factor columns can be converted to character columns as shown below.

person <- data.frame(  jobs = c("scientist", "analyst")
                  , pay = c(160000, 100000)
                  , age = c(30, 25) 
                  )

# Convert all columns to character:

person[] <- lapply(person, as.character)

# We can remove all rows from the data frame which have missing (NA) values using the 
# complete.cases function, which returns a logical vector indicating which cases have
# no missing values:

person_with_missing_info <- data.frame(   jobs = c("scientist", "secret agent", "analyst")
                                        , pay = c(160000, NA, 120000)
                                        , age = c(30, NA, 45) 
)

person_with_missing_info[complete.cases(person_with_missing_info), ]
#        jobs    pay age
# 1 scientist 160000  30
# 3   analyst 120000  45

# Let's say we want to only omit rows which have missing jobs info:

person_with_missing_info[complete.cases(person_with_missing_info[, c('jobs')]), ]
#            jobs    pay age
# 1     scientist 160000  30
# 2  secret agent     NA  NA
# 3       analyst 120000  45

# Let's say we want to replace NA vales with zeros - we can do this simply using the is.na function:

person_with_missing_info[is.na(person_with_missing_info)] <- 0

# Joining data frames

# We can do inner/outer/cross joins on data frames. As an example, lets take the 2 frames below.
# As a note, the R rep function replicates the input vector or list.

data_frame1 = data.frame(CustomerId = c(1:6), Product = c(rep("Toaster", 3), rep("Radio", 3)))

data_frame2 = data.frame(CustomerId = c(2, 4, 6), State = c(rep("Alabama", 2), rep("Ohio", 1)))

# By using the merge function and its optional parameters, we can do SQL style joins on our data.
# R automatically joins the frames by common variable names. Some exaples are provided below:

merge(x = data_frame1, y = data_frame2)                                  # Performs an inner join

merge(x = data_frame1, y = data_frame2, by = "CustomerId", all = TRUE)   # Performs an outer join

merge(x = data_frame1, y = data_frame2, by = "CustomerId", all.x = TRUE) # Performs a left join

merge(x = data_frame1, y = data_frame2, by = "CustomerId", all.y = TRUE) # Performs a right join

merge(x = data_frame1, y = data_frame2, by = NULL)                       # Performs a cross join

# You can merge/ join on multiple columns by giving by a vector, e.g., by = c("CustomerId", "OrderId")

# We can also use the sqldf package, which allows you to express these operations in SQL:

install_and_load_package('sqldf')

# Inner join:

result_frame <- sqldf("SELECT CustomerId, Product, State 
                       FROM data_frame1
                       JOIN data_frame2 USING(CustomerID)")

# Left join:

result_frame <- sqldf("SELECT CustomerId, Product, State 
                       FROM data_frame1
                       LEFT JOIN data_frame2 USING(CustomerID)")

## Factors

# Factors are used to represent categorical data and can be unordered or ordered. One can think of a factor as 
# an integer vector where each integer has a label. Factors are important in statistical modeling and are treated
# specially by modelling functions like lm() and glm(). 

# Using factors with labels is better than using integers because factors are self-describing. Having a variable 
# that has values "Male" and "Female" is better than a variable that has values 1 and 2. 

factor_example <- factor(c("yes", "yes", "no", "yes"))

factor_example
# [1] yes yes no  yes
# Levels: no yes

## Formulas

# Statistical functions in R make heavy use of formulas. The formula interface allows you to concisely specify 
# which columns to use when fitting a model, as well as the behavior of the model. When running model functions 
# like lm (Linear Regression), the formula specifies which regression coefficients shall be estimated.

# On the left side of the the dependent variable is specified, while the right hand side contains the independent 
# variables. 

formula1 <- formula(dependent_variable ~ independent_variable)

class(formula1)  # returns  "formula"

# Use the mtcars data frame to build our model / show our examples:

data_frame_to_use = mtcars

# Create new columns in our data frame marking the dependent / independent variables to use for our examples:

data_frame_to_use$dependent_variable = mtcars$mpg
data_frame_to_use$independent_variable = mtcars$wt

# Run the linear regression model function:

model1 <- lm(formula1, data = data_frame_to_use)

# Technically, the formula call above is redundant because the tilde-operator is an infix function that returns 
# an object with a formula class:

formula1 <- dependent_variable ~ independent_variable

class(formula1)  # returns  "formula"

# The advantage of the formula function over ~ is that it also allows an environment for evaluation to be specified:

form_mt <- formula(dependent_variable ~ independent_variable, env = data_frame_to_use)

# The formula operator + means to include a column, not to mathematically add two columns together:

data_frame_to_use$independent_variable2 = data_frame_to_use$vs

formula1 <- formula( dependent_variable ~ independent_variable + independent_variable2, data = data_frame_to_use)

# Some more basic formula operator examples:

# "-" below means: Include independent_variable but exclude independent_variable2:

formula1 <- formula( dependent_variable ~ independent_variable - independent_variable2, data = data_frame_to_use)

# ":" below means: Estimate the independent_variable and independent_variable2 interactions:

formula1 <- formula( dependent_variable ~ independent_variable:independent_variable2, data = data_frame_to_use)

# "*" below means: Include columns as well as their interactions. In other words, include independent_variable
# and independent_variable2 as well as their interactions 

formula1 <- formula( dependent_variable ~ independent_variable * independent_variable2, data = data_frame_to_use)

# Same as:

formula1 <- formula( dependent_variable ~ independent_variable 
                     + independent_variable2 
                     + independent_variable:independent_variable2
                     , data = data_frame_to_use)

#	"|" below means: Estimate dependent_variable as a function of independent_variable conditional 
# on independent_variable2:

formula1 <- formula( dependent_variable ~ independent_variable | independent_variable2, data = data_frame_to_use)

# Finally, "." is shorthand for using all available variables. In the below case, the data argument is used to
# obtain the available variables which are not on the left hand side:

formula1 <- formula( dependent_variable ~ . , data = data_frame_to_use)

## Data Tables

# Data.table is a package that extends the functionality of data frames from base R, particularly improving on their
# performance and syntax.  Functions that work on a data.frame will also work with a data.table. There are
# many ways to create, load or coerce to a data.table.

# There is a constructor of the same name:

install_and_load_package('data.table')

data_table1 <- data.table(
  x = letters[1:5],
  y = 1:5,
  z = (1:5) > 3
)

data_table1
#    x y     z
# 1: a 1 FALSE
# 2: b 2 FALSE
# 3: c 3 FALSE
# 4: d 4  TRUE
# 5: e 5  TRUE

# Unlike data.frame, data.table will not coerce strings to factors:

sapply(data_table1, class)
#           x         y         z
# "character" "integer" "logical"

# If you have another R object (such as a matrix), you must use as.data.table to coerce it to a data.table:

mat <- matrix(0, ncol = 10, nrow = 10)

data_table2 <- as.data.table(mat)
# or
data_table2 <- data.table(mat)

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

## Hashmaps

# Although R does not provide a native hash table structure, similar functionality can be achieved by leveraging the
# fact that the environment object returned from new.env (by default) provides hashed key lookups. The following
# two statements are equivalent, as the hash parameter defaults to TRUE:

hash_map <- new.env(hash = TRUE)
hash_map <- new.env()

# Insertion of elements may be done using either of the '<-' or '$' methods:

hash_map[["key"]] = "value"
hash_map$key2 = "value2"

hash_map$key         # returns "value"
hash_map[["key2"]]   # returns "value2"

# Elements can be removed using rm:

rm("key", envir = hash_map)

ls.str(hash_map)     # returns key2 :  chr "value2"

# One of the major benefits of using environment objects as hash tables is their ability to store virtually any
# type of object as a value, even other environments:

hash_map2 <- new.env()
hash_map2[["a"]] <- LETTERS
hash_map2[["b"]] <- as.list(x = 1:5, y = matrix(rnorm(10), 2))
hash_map2[["c"]] <- head(mtcars, 3)
hash_map2[["d"]] <- Sys.Date()
hash_map2[["e"]] <- Sys.time()

## Control Flow Structures

# Standard if / else if / else statement:

x <- 0

if (x < 0) {
  print("Negative")
} else if (x > 0) {
  print("Positive")
} else {
  print("Zero")
}

# Outputs:
# [1] "Zero"

# R allows us to write inline constructs such as the one below:

x <- 3

y <- if(x > 3) "Larger than 3" else "Less than or equal to 3"

y  # returns "Less than or equal to 3"

# Standard for loop:

values <- c("value1","value2")

for (value in values) {
  print(value)   # prints out "value1", followed by "value2"
}

# To illustrate the effect of good for loop construction, we will calculate the mean of each column in four different
# ways:

# 1. Using a poorly optimized for loop
# 2. Using a well optimized for loop
# 3. Using an *apply family of functions
# 4. Using the colMeans function

# 1. Using a poorly optimized for loop example (mean time to run: ~290 ms):

poor_column_mean <- NULL

for ( i in 1 : length(mtcars) ) {
  poor_column_mean[i] <- mean(mtcars[[i]])
}

# 2. Using a well optimized for for loop example (mean time to run: ~260 ms):

better_column_mean <- vector("numeric", length(mtcars))

for (i in seq_along(mtcars)) {
  better_column_mean <- mean(mtcars[[i]])
}

# 3. Using an *apply family of functions example (mean time to run: ~120 ms):

vapply_column_mean <- vapply(mtcars, mean, numeric(1))

# 4. Using the colMeans function (mean time to run: ~180 ms):

colMeans_column_mean <- colMeans(mtcars)

# The while loop

counter <- 0

while (counter < 3) {
  cat(counter, "\n")
  counter <- counter + 1
}

# Output:
# 0
# 1
# 2

# The repeat loop

vector <- c("Repeat","loop")
counter <- 0

repeat {
  print(vector)
  counter <- counter + 1
  
  if(counter >= 2) {
    break
  }
}

# Outputs:
# [1] "Repeat" "loop"  
# [1] "Repeat" "loop" 

## DPLYR

# dplyr introduces a grammar of data manipulation in R. It provides a consistent interface to work with data no
# matter where it is stored: data.frame, data.table, or a database. The key pieces of dplyr are written using Rcpp,
# which makes it very fast for working with in-memory data.
# 
# dplyr's philosophy is to have small functions that do one thing well. The five simple functions (filter, arrange,
# select, mutate, and summarise) can be used to reveal new ways to describe data. When combined with group_by,
# these functions can be used to calculate group wise summary statistics.

install_and_load_package('dplyr')

mtcars_table <- as_data_frame(tibble::rownames_to_column(mtcars, "cars"))

# Filter helps subset rows that match certain criteria:

filter(mtcars_table, cyl == 4)    # returns all cars that have 4 cylinders

filter(mtcars_table, cyl == 4 | cyl == 6, gear == 5) # returns the cars which have either 4 or 6 cylinders and 5 gears

slice(mtcars_table, 6:9)  # returns rows 6 through 9

# Arrange is used to sort the data by a specified variable(s).

arrange(mtcars_table, hp)  # orders the data by horsepower - hp

arrange(mtcars_table, desc(mpg), cyl) # orders the data by miles per gallon in desc order, followed by # of cylinders

# Select is used to select only a subset of variables

select (mtcars_table, mpg, disp, wt, qsec, vs)  # returns mpg, disp, wt, qsec, and vs from mtcars_tbl

select (mtcars_table, cylinders = cyl, displacement = disp) # returns and renames the cylinders and displacement columns

select (mtcars_table, mpg:wt) # returns all of the columns between the mpg and wt columns

# Mutate can be used to add new columns to the data.

mutate(mtcars_table, weight_ton = wt / 2, weight_pounds = weight_ton * 2000)  # Adds 2 new columns to the data frame

# To retain only the newly created columns, use transmute instead of mutate:

transmute(mtcars_table, weight_ton = wt/2, weight_pounds = weight_ton * 2000) # Only has the 2 columns specified

# Summarise calculates summary statistics of variables by collapsing multiple values to a single value.

summarise(mtcars_table, mean_mpg = mean(mpg), sd_mpg = sd(mpg),
          mean_disp = mean(disp), sd_disp = sd(disp))

# group_by can be used to perform group wise operations on data.

by_cyl <- group_by(mtcars_table, cyl)
summarise(by_cyl, mean_mpg = mean(mpg), sd_mpg = sd(mpg))

# Putting it all together:

# Example with intermediate results (simple):

selected <- select(mtcars_table, cars:hp, gear)
ordered <- arrange(selected, cyl, desc(mpg))
by_cyl <- group_by(ordered, gear)
filter(by_cyl, mpg > 20, hp > 75)

# Example without intermediate results (more complex):

filter(
  group_by(
    arrange(
      select(
        mtcars_table, cars:hp
      ), cyl, desc(mpg)
    ), cyl
  ),mpg > 20, hp > 75
)

# dplyr operations can be chained using the pipe %>% operator:

mtcars_table %>%
  select(cars:hp) %>%
  arrange(cyl, desc(mpg)) %>%
  group_by(cyl) %>%
  filter(mpg > 20, hp > 75)

# summarise_all() is used to apply functions to all (non-grouping) columns:

mtcars_table %>%
  summarise_all(n_distinct)

# To summarise specific multiple columns, use summarise_at: 

mtcars_table %>%
  group_by(cyl) %>%
  summarise_at(c("mpg", "disp", "hp"), mean)

# To select columns conditionally, use summarise_if:

mtcars_table %>%
  group_by(cyl) %>%
  summarise_if(is.numeric, mean)

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

## Data Visualization 

# Plotting data

# Below are some simple examples of how to plot a line in R, how to fit a line to some points, and how to add 
# more points to a graph.

# Make a very simply plot of (x, y) values and plot them:

x <- c(4, 6, 8, 11, 15, 18)
y <- c(2.8, 4.6, 6.2, 5.5, 7.8, 8.8)

plot(x, y)

# We can use a bunch of parameters to produce a more descriptive plot, as shown below:

plot(  x , y
     , xlab="X Axis Label"
     , ylab="Y Axis Label"
     , main = "Plot Title"
     , xlim = c(0, 20)     # X axis range
     , ylim = c(0, 10)     # Y axis range
     , pch = 4             # Set the plotting symbol to 'X'
     , col = "red"         # Set the plot color to red
     )

# Create a linear model and plot it:

lin_model <- lm(y ~ x)

abline(lin_model)

# Add more points to our graph:

x2 <- c(3.3, 6.6, 9.9, 13.2)
y2 <- c(1.6, 3.3, 5, 6.6 )

# Create a 2D line plot for the 4 new values:

points(  x2, y2
       , type="o"     # Use a line plot
       , col = "blue"
       )

# Histograms

# A histogram plots the frequencies that data appears within certain ranges. Below, we plot a simple histogram
# showing our mtcars data horse power distribution. 

data(mtcars)

hist(mtcars$hp, main = "Distribution of HP", xlab = "Horse Power")

# For our histogram, R will automatically calculate the intervals to use, although we can specify the amount of
# breaks we want using the breaks option:

hist(mtcars$hp, main = "Distribution of HP", xlab = "HP", breaks = 4)

# Boxplot

# A boxplot provides a graphical view of the median, quartiles, maximum, and minimum of a data set. 

boxplot(mtcars$mpg, main = "Boxplot for Miles per Gallon Data")

# We can also create a boxplot of a numerical variable grouped by a categorical variable

# Use the iris data set to create a boxplot of the sepal.length column grouped by species:

data(iris)

boxplot(Sepal.Length ~ Species, data = iris, main = "Boxplot of Sepal Length Grouped by Species")

# ggplot2

# ggplot is a popular visualization package which we can use to create elegant and complex plots.

# Let's illustrate some simple plots we can make using this library.

install_and_load_package('ggplot2')

# Create a regular dot plot of Sepal (length, width) points using our iris data:

ggplot( iris              
      , aes(x = Sepal.Length, y = Sepal.Width)) +   # Specify the aesthetic mappings (variable mappings)
        geom_point()  # Specify the geometric object. Here, we specify points (dots) to obtain a plot of points     

# Aesthetic mappings allow us to use properties within our data to influence the visual characeristics of our graphs.
# Lets make the same plot as above, except we will specify a different color for each flower species:

ggplot( iris              
      , aes(x = Sepal.Length, y = Sepal.Width, color = Species)) + 
        geom_point() 

# We can also make plots using different geometric shapes / objects. 

# Create a line chart for the iris data set:

ggplot( iris              
      , aes(x = Sepal.Length, y = Sepal.Width, color = Species)) + 
        geom_line()   

# Create a smoothed line chart:

ggplot( iris              
      , aes(x = Sepal.Length, y = Sepal.Width, color = Species)) + 
        geom_smooth() 

# Create a bar chart:

ggplot( data = iris          
      , aes(x = Sepal.Width)) + 
        geom_bar()              

# Create a histogram (which is similar to the bar chart above):

ggplot( data = iris          
      , aes(x = Sepal.Width)) + 
        geom_histogram()       

# Sometimes, we may want to display multiple plots in one image with the different facets. An advantage of 
# this method is that all axes share the same scale across the charts, making it easy to compare them at a glance.
# You can construct a plot with multiple facets by using the facet_wrap()

# Use the iris dataset and the facet_wrap function to plot the iris sepal width accross the different species:

ggplot( iris
      , aes(x = Sepal.Length, y = Sepal.Width)) + 
        geom_point() + 
        facet_wrap(~Species)

# Create a mew graph wiht added labels to our visuals using the labs function:

ggplot( iris
      , aes(x = Sepal.Length, y = Sepal.Width, color = Species)) +
        geom_point() +
        labs( title = "Width and Length Iris Data",
              subtitle = "Simple description of our data can be included here",
              x = "Sepal Length",
              y = "Sepal Width",
              color = "Species"
            )

# Use the facet_grid function to facet our data by more than one categorical variable:

data(mpg)

ggplot( mpg
      , aes(x = displ, y = hwy)) +
        geom_point() +
        facet_grid(year ~ cyl)  # Create a facet grid for year / cylinder data

# Time Series Data

# Time series data can be stored as a ts object. ts objects contain information about seasonal frequency that is used
# by ARIMA functions. It also allows for calling of elements in the series by date using the window command.

# Create a dummy dataset of 100 observations:

x <- rnorm(100)

# Convert this vector to a ts object with 100 annual observations:

x <- ts(x, start = c(1900), freq = 1)

plot(x)

# Convert this vector to a ts object with 100 monthly observations starting in July:

x <- ts(x, start = c(1900, 7), freq = 12)

plot(x)

# Exploratory Data Analysis with time-series data

# Lets load some air passanger data:

data(AirPassengers)

# Plot the raw data:

plot(AirPassengers) 

# Fit a trend line:

abline(reg=lm(AirPassengers~time(AirPassengers))) 

## Reading and Writing Data

# cat takes one or more character vectors as arguments and prints them to the console. If the character vector 
# has a length greater than 1, arguments are separated by a space (by default):

cat(c("hello", "world", "\n"))    # outputs 'hello world'

# Reading from or writing to a file connection

# We don't always have the liberty to read from or write to a local system path. To establish a file connection 
# to read data,  use the file() command in read mode ("r" is for read mode):

stdin_connection <- file("stdin", "r")     # when just standard input/output for files are available

file_connection <- file("README.md", "r")  # when file is local

# We can use the readline method to read the contents of the file. The n parameters specifies the number of lines 
# we want to read. Setting n to 1 means that we're reading the file line by line:

read_file = function(file_path) {
  connection = file(file_path, "r")
  while ( TRUE ) {
    line = readLines(connection, n = 1, warn = FALSE)
    if ( length(line) == 0 ) {
      break
    }
    print(line)
  }
  close(connection)
}

read_file("README.md")  # prints the results of README.md

# You can change value of n (say 10, 20 etc.) for reading data blocks (i.e. we can use 10 to read 10 lines in
# one go). To read complete file in one go set n = -1.

all_lines <- readLines(file_connection, n = -1, warn = FALSE)

print(all_lines)        # prints the results of README.md

# Close the open connections:

close(file_connection)

close(stdin_connection)

# After processing data, you can write the results back to the file connection using many different commands like 
# writeLines(),cat() etc. which are capable of writing to a file connection.

write_file_connection <- file("result.data", "w") # when file is local

# Then write the data as follows:

writeLines("text", write_file_connection, sep = "\n")

close(write_file_connection)

# Delete the results.data file:

file.remove("result.data")

# Importing .csv files

# Get the file path of a CSV included in R's utils package

csv_path <- system.file("misc", "exDIF.csv", package = "utils")

df <- read.csv(csv_path)

# The data.table package introduces the function fread. While it is similar to read.table, fread is usually faster and
# more flexible. It tries to 'guess' the file's delimiter automatically:

dt <- fread(csv_path)

# To return an ordinary data.frame, set the data.table parameter to FALSE:

df <- fread(csv_path, data.table = FALSE)

# Data can be written to a CSV file using write.csv():

write.csv(mtcars, "mtcars.csv")

# Importing multiple csv files:

files = list.files(pattern="*.csv")

data_list = lapply(files, read.table, header = TRUE)

print (data_list)

## Web Scraping and Parsing

# rvest is a package for web scraping and parsing by Hadley Wickham inspired by Python's Beautiful Soup. It
# leverages Hadley's xml2 package's libxml2 bindings for HTML parsing.

# To scrape the table of R milestones from the Wikipedia page on R, the code would look like:

install_and_load_package('rvest')

url <- 'https://en.wikipedia.org/wiki/R_(programming_language)'

# Scrape HTML from website and use pipe operators to transform it into a data frame:

url %>%
  # Read the url html:
  read_html() %>%
  # Select HTML tag with class="wikitable":
  html_node(css = '.wikitable') %>%
  # Parse table into data.frame:
  html_table() %>%
  # Trim the description to 100 characters for printing:
  dplyr::mutate(Description = substr(Description, 1, 100))

## Feature Selection

# Feature selection is about removing extraneous features / data cleaning.

# A feature that has near zero variance is a good candidate for removal. You can manually detect numerical 
# variance below your own threshold:

data(iris)

variances <- apply(iris, 2, var)

variances[which(variances <= 0.0025)]    # returns character(0)

# Or, you can use the caret package to find near zero variance:

install_and_load_package('caret') 

names(iris)[nearZeroVar(iris)]         # returns character(0)

# Removing features with high numbers of NA. If a feature is largely lacking data, it is a good candidate 
# for removal:

install_and_load_package('VIM')

# Load the sleep data:

data(sleep)

# Use the colMeans and is.na functions to find the ratio of missing values for each column

colMeans( is.na(sleep) )
#    BodyWgt   BrainWgt       NonD      Dream     Sleep        Span       Gest
# 0.00000000 0.00000000 0.22580645 0.19354839 0.06451613 0.06451613 0.06451613

# In the above case, we may want to remove NonD and Dream, which have around 20% of their values missing 

# To drop columns, there's the subset command, which we could use as demonstrated below:

sleep_with_missing_col <- subset(sleep, select = -c(NonD, Dream))

# Or we can use regular frame filtering and %in% operator:

columns_to_drop <- c("NonD", "Dream")

sleep_with_missing_col <- sleep[ , !(names(sleep) %in% columns_to_drop)]

# Removing Closely Correlated Features

# Closely correlated features may add variance to your model, and removing one of a correlated pair might help
# reduce that. There are lots of ways to detect correlation. Here's one:

install_and_load_package('purrr') 

# Select correlatable vars (numeric ones)

to_correlate <- mtcars %>% keep ( is.numeric )

# Calculate correlation matrix

correlation_matrix <- cor(to_correlate)

correlation_matrix

# Pick only one out of each highly correlated pair's mirror image

correlation_matrix[upper.tri(correlation_matrix)] <- 0

# We don't remove the highly-correlated-with-itself group

diag(correlation_matrix) <- 0

# Find features that are highly correlated with another feature at the +- 0.85 level

apply(correlation_matrix, 2, function(x) any( abs(x) >= 0.85 ) )
#  mpg   cyl  disp    hp  drat    wt  qsec    vs    am  gear  carb 
# TRUE  TRUE  TRUE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE 

# We'll want to look at what MPG is correlated to so strongly, and decide what to keep and what to toss. 
# Same for cyl and disp. Alternatively, we might need to combine some strongly correlated features.

## Linear Regression 

# The built-in mtcars data frame contains information about 32 cars, including their weight, fuel efficiency 
# (in miles per gallon), speed, etc. If we are interested in the relationship between fuel efficiency (mpg) 
# and weight (wt) we may start plotting those variables with:

plot(mpg ~ wt, data = mtcars, col = 2)

# The plots shows a (linear) relationship!. Then if we want to perform linear regression to determine the 
# coefficients of a linear model, we would use the lm function.
# The ~ here means "explained by", so the formula mpg ~ wt means we are predicting mpg as explained by wt:

example_model <- lm(mpg ~ disp, data = mtcars)

# We can use the summary function to display the key output / results:

summary(example_model)

# Using the 'predict' function: Once a model is built predict is the main function to test with new data.

# First, we sample from our original data

set.seed(1234)

new_data <- sample(mtcars$disp, 5)

new_data   # returns [1] 258.0  71.1  75.7 145.0 400.0

# Create a new data frame with the same column names as the original data

new_df <- data.frame( disp = new_data )

new_df

predict(example_model, new_df)

# Checking accuracy

# Let's create a new data frame and use our model to make predictions and check our end results.
# Create a new data frame containing the first 10 results from our mtcars data:

new_df2 = data.frame(mpg = mtcars$mpg[1:10], disp = mtcars$disp[1:10])

# Use our linear model to make predictions on the data set created above:

predictions <- predict(example_model, new_df2)

# Calculate the root mean square error comparing our generated results and the original data set:

sqrt(mean( (predictions - new_df2$mpg)^2 , na.rm = TRUE))   # returns 2.325148

# Checking for nonlinearity with polynomial regression

# Sometimes when working with linear regression we need to check for non-linearity in the data. One way to do this
# is to fit a polynomial model and check whether it fits the data better than a linear model. There are other reasons,
# such as theoretical, that indicate to fit a quadratic or higher order model because it is believed that the variables
# relationship is inherently polynomial in nature.

# Let's fit a quadratic model for the mtcars dataset. For a linear model see Linear regression on the mtcars dataset.

# A linear fit will show that disp is not significant.

fit0 = lm(mpg ~ wt + disp, mtcars)

summary(fit0)

# Output:
# Coefficients:
#   Estimate Std. Error t value Pr(>|t|)    
# (Intercept) 34.96055    2.16454  16.151 4.91e-16 ***
#   wt          -3.35082    1.16413  -2.878  0.00743 ** 
#   disp        -0.01773    0.00919  -1.929  0.06362 .  
# ---
#   Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
# 
# Residual standard error: 2.917 on 29 degrees of freedom
# Multiple R-squared:  0.7809,	Adjusted R-squared:  0.7658 
# F-statistic: 51.69 on 2 and 29 DF,  p-value: 2.744e-10

# Then, to get the result of a quadratic model, we added I(disp^2). The new model appears better when looking at
# R^2 and all variables are significant.

fit1 = lm(mpg ~ wt + disp + I( disp ^ 2 ), mtcars)

summary(fit1)

# Output:
# Coefficients:
#   Estimate Std. Error t value Pr(>|t|)    
# (Intercept) 41.4019837  2.4266906  17.061  2.5e-16 ***
#   wt          -3.4179165  0.9545642  -3.581 0.001278 ** 
#   disp        -0.0823950  0.0182460  -4.516 0.000104 ***
#   I(disp^2)    0.0001277  0.0000328   3.892 0.000561 ***
#   ---
#   Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
# 
# Residual standard error: 2.391 on 28 degrees of freedom
# Multiple R-squared:  0.8578,	Adjusted R-squared:  0.8426 
# F-statistic: 56.32 on 3 and 28 DF,  p-value: 5.563e-12

# Another way to specify polynomial regression is using poly with parameter raw=TRUE, otherwise orthogonal
# polynomials will be considered (see the help(ploy) for more information). We get the same result using:

summary(lm(mpg ~ wt + poly(disp, 2, raw=TRUE), mtcars))

## Logistic Rregression 

# Example logistic regression on the Titanic dataset

# Read the data:

url <- "http://biostat.mc.vanderbilt.edu/wiki/pub/Main/DataSets/titanic.txt"

titanic <- read.csv(file = url, stringsAsFactors = FALSE)

# Clean the missing values. In that case, we replace the missing age values with the average:

titanic$age[is.na(titanic$age)] <- mean(titanic$age, na.rm = TRUE)

# Train the model:

titanic.train <- glm(  survived ~ pclass + sex + age
                     , family = binomial
                     , data = titanic
                     )

# Display the model summary:

summary(titanic.train)

# Output:
# glm(formula = survived ~ pclass + sex + age, family = binomial, data = titanic)
# Call:  glm(formula = survived ~ pclass + sex + age, family = binomial, 
#            data = titanic)
# 
# Coefficients:
#   (Intercept)    pclass2nd    pclass3rd      sexmale          age  
# 4.52216     -1.49523     -2.84127     -3.08671     -0.04931  
# 
# Degrees of Freedom: 632 Total (i.e. Null);  628 Residual
# (680 observations deleted due to missingness)
# Null Deviance:	    869.5 
# Residual Deviance: 539.7 	AIC: 549.7

## Random Forrest

# Random Forests is a learning method mainly used for classification. It is based on generating a large 
# number of decision trees, each constructed using a different subset of your training set. 

# Load the package using our function:

install_and_load_package('randomForest')

# Let's split our data set into training and validation data and train a random forrest algorithm:

# Set random seed to make results reproducible:

set.seed(17)

# Calculate the size of each of the data sets:

data_set_size <- floor( nrow(iris) / 2 )

# Generate a random sample of "data_set_size" indexes

indexes <- sample(1:nrow(iris), size = data_set_size)

# Assign the data to the correct sets

training <- iris[indexes,]
validation1 <- iris[-indexes,]

# Some important random forrest parameters:
# ntree: Defines the number of trees to be generated. It is typical to test a range of values for this parameter
#        (i.e. 100,200,300,400,500) and choose the one that minimises the OOB estimate of error rate.
# mtry: Is the number of features used in the construction of each tree. These features are selected at random, 
#       which is where the "random" in "random forests" comes from. The default value for this parameter, when 
#       performing classification, is sqrt(number of features).
# importance: Enables the algorithm to calculate variable importance.

# Perform the training:

rf_classifier = randomForest(Species ~ ., data = training, ntree = 100, mtry = 2, importance=TRUE)

# Validation set assessment #1: looking at confusion matrix. The confusion matrix is a good way of looking at 
# how good our classifier is performing when presented with new data.

prediction_for_table <- predict(rf_classifier, validation1[, -5])

table(observed=validation1[, 5], predicted = prediction_for_table)
#             predicted
# observed     setosa versicolor virginica
# setosa         29          0         0
# versicolor      0         20         3
# virginica       0          1        22

## XGBoost

# XGBoost is a library designed and optimized for boosting trees algorithms.
# It's a highly successful algorithm, having won multiple machine learning competitions.

# Import the iris dataset

install_and_load_package( c('datasets', 'xgboost'))

data(iris)

# The first 4 columns of the dataset supply the feature vector, while the last column contains the 
# corresponding labels:

x = as.matrix(iris[, 1:4])
y = as.numeric(factor(iris[, 5])) - 1

# Run the xgboost command:

model <- xgboost(data = x, label = y, nrounds = 10)
# [1]	train-rmse:0.685905 
# [2]	train-rmse:0.494086 
# [3]	train-rmse:0.357192 
# [4]	train-rmse:0.262149 
# [5]	train-rmse:0.194319 
# [6]	train-rmse:0.147978 
# [7]	train-rmse:0.110566 
# [8]	train-rmse:0.083971 
# [9]	train-rmse:0.064658 
# [10]	train-rmse:0.050646 

# We can see that the algorithm went through 10 iterations, and that the training error, as measured by rmse, 
# is decreasing, which is great. 

# We didn't define/ supply and test data. Therefore, to assess the performance of the model on unseen data, 
# we perform cross-validation:

set.seed(1)

cv <- xgb.cv(  data = x
             , label = y
             , nfold = 5
             , nrounds = 60
          )

# Let´s take a closer look at some XGBoost hyperparameters:
# Objective: specifies the task of XGBoost and determines the output: the most common ones are linear
# (reg:linear) and logistic regression (reg:logistic), multiclass logistic regression (multi:softprob) 
# and ranking (rank:pairwise).
# eval_metric: specifies the evaluation metric used by XGBoost. It heavily depends on the objective 
# (rmse for regression, and error for classification, mean average precision for ranking) and users can 
# create custom ones.
# max_depth: specifies the max deepness of the trees (maximal number of splits) used by XGBoost. The 
# bigger this number, the more abstract our model can be, but we risk overfitting the model to the data.
# eta controls: the learning rate: the higher eta, the higher the contribution of new trees. Smaller 
# number will prevent overfitting, but increase the number of rounds XGBoost will need to converge.

params <- list("objective" = "multi:softprob",
               "eval_metric" = "mlogloss",
               "max_depth" = 6,
               "eta" = 0.3,
               "gamma" = 0,
               "colsample_bytree" = 1,
               "min_child_weight" = 1,
               "num_class" = 3)

# early_stopping_rounds: This parameter specifies when to stop the training / algorithm. Setting it to 8 
# means that we're making the algorithm stop if there has not been an improvement in the test score (test-rmse) 
# for 8 rounds.

cv <- xgb.cv(   data = x
              , label = y
              , nfold = 5
              , nrounds = 100
              , early_stopping_rounds = 8
              , params = params)

# After running the above, we can see that our algoirthm will use test_mlogloss for early stopping and will 
# stop at ~20 iterations.

## Future To Do List

# 1. Add in caret package examples.
# 2. Come up with clearer machine learning explanations / examples.

