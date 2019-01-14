## Factors

# Factors are used to represent categorical data and can be unordered or ordered. One can think of a factor as 
# an integer vector where each integer has a label. Factors are important in statistical modeling and are treated
# specially by modelling functions like lm() and glm(). 

# Using factors with labels is better than using integers because factors are self-describing. Having a variable 
# that has values "Male" and "Female" is better than a variable that has values 1 and 2. 

factor_example <- factor(c("yes", "yes", "no", "yes"))

factor_example
# [1] yes yes no  yes
# Levels: no yes

