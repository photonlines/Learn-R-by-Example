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

