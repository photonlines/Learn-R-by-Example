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

