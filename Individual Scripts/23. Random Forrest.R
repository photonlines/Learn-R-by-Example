## Random Forrest

# Random Forests is a learning method mainly used for classification. It is based on generating a large 
# number of decision trees, each constructed using a different subset of your training set. 

# Load the package using our function:

install_and_load_package('randomForest')

# Let's split our data set into training and validation data and train a random forrest algorithm:

# Set random seed to make results reproducible:

set.seed(17)

# Calculate the size of each of the data sets:

data_set_size <- floor( nrow(iris) / 2 )

# Generate a random sample of "data_set_size" indexes

indexes <- sample(1:nrow(iris), size = data_set_size)

# Assign the data to the correct sets

training <- iris[indexes,]
validation1 <- iris[-indexes,]

# Some important random forrest parameters:
# ntree: Defines the number of trees to be generated. It is typical to test a range of values for this parameter
#        (i.e. 100,200,300,400,500) and choose the one that minimises the OOB estimate of error rate.
# mtry: Is the number of features used in the construction of each tree. These features are selected at random, 
#       which is where the "random" in "random forests" comes from. The default value for this parameter, when 
#       performing classification, is sqrt(number of features).
# importance: Enables the algorithm to calculate variable importance.

# Perform the training:

rf_classifier = randomForest(Species ~ ., data = training, ntree = 100, mtry = 2, importance=TRUE)

# Validation set assessment #1: looking at confusion matrix. The confusion matrix is a good way of looking at 
# how good our classifier is performing when presented with new data.

prediction_for_table <- predict(rf_classifier, validation1[, -5])

table(observed=validation1[, 5], predicted = prediction_for_table)
#             predicted
# observed     setosa versicolor virginica
# setosa         29          0         0
# versicolor      0         20         3
# virginica       0          1        22

