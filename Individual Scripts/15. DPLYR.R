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

