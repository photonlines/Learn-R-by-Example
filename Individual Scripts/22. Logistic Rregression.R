## Logistic Rregression 

# Example logistic regression on the Titanic dataset

# Read the data:

url <- "http://biostat.mc.vanderbilt.edu/wiki/pub/Main/DataSets/titanic.txt"

titanic <- read.csv(file = url, stringsAsFactors = FALSE)

# Clean the missing values. In that case, we replace the missing age values with the average:

titanic$age[is.na(titanic$age)] <- mean(titanic$age, na.rm = TRUE)

# Train the model:

titanic.train <- glm(  survived ~ pclass + sex + age
                     , family = binomial
                     , data = titanic
                     )

# Display the model summary:

summary(titanic.train)

# Output:
# glm(formula = survived ~ pclass + sex + age, family = binomial, data = titanic)
# Call:  glm(formula = survived ~ pclass + sex + age, family = binomial, 
#            data = titanic)
# 
# Coefficients:
#   (Intercept)    pclass2nd    pclass3rd      sexmale          age  
# 4.52216     -1.49523     -2.84127     -3.08671     -0.04931  
# 
# Degrees of Freedom: 632 Total (i.e. Null);  628 Residual
# (680 observations deleted due to missingness)
# Null Deviance:	    869.5 
# Residual Deviance: 539.7 	AIC: 549.7

