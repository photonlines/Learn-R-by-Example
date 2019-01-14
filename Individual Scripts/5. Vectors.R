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

