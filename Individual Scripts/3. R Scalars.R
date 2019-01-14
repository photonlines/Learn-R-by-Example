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

