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

