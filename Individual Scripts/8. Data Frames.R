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

