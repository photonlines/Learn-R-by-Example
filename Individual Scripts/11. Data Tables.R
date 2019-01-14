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

