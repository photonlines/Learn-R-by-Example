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

