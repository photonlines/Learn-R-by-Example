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

