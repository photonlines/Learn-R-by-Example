## XGBoost

# XGBoost is a library designed and optimized for boosting trees algorithms.
# It's a highly successful algorithm, having won multiple machine learning competitions.

# Import the iris dataset

install_and_load_package( c('datasets', 'xgboost'))

data(iris)

# The first 4 columns of the dataset supply the feature vector, while the last column contains the 
# corresponding labels:

x = as.matrix(iris[, 1:4])
y = as.numeric(factor(iris[, 5])) - 1

# Run the xgboost command:

model <- xgboost(data = x, label = y, nrounds = 10)
# [1]	train-rmse:0.685905 
# [2]	train-rmse:0.494086 
# [3]	train-rmse:0.357192 
# [4]	train-rmse:0.262149 
# [5]	train-rmse:0.194319 
# [6]	train-rmse:0.147978 
# [7]	train-rmse:0.110566 
# [8]	train-rmse:0.083971 
# [9]	train-rmse:0.064658 
# [10]	train-rmse:0.050646 

# We can see that the algorithm went through 10 iterations, and that the training error, as measured by rmse, 
# is decreasing, which is great. 

# We didn't define/ supply and test data. Therefore, to assess the performance of the model on unseen data, 
# we perform cross-validation:

set.seed(1)

cv <- xgb.cv(  data = x
             , label = y
             , nfold = 5
             , nrounds = 60
          )

# Let?s take a closer look at some XGBoost hyperparameters:
# Objective: specifies the task of XGBoost and determines the output: the most common ones are linear
# (reg:linear) and logistic regression (reg:logistic), multiclass logistic regression (multi:softprob) 
# and ranking (rank:pairwise).
# eval_metric: specifies the evaluation metric used by XGBoost. It heavily depends on the objective 
# (rmse for regression, and error for classification, mean average precision for ranking) and users can 
# create custom ones.
# max_depth: specifies the max deepness of the trees (maximal number of splits) used by XGBoost. The 
# bigger this number, the more abstract our model can be, but we risk overfitting the model to the data.
# eta controls: the learning rate: the higher eta, the higher the contribution of new trees. Smaller 
# number will prevent overfitting, but increase the number of rounds XGBoost will need to converge.

params <- list("objective" = "multi:softprob",
               "eval_metric" = "mlogloss",
               "max_depth" = 6,
               "eta" = 0.3,
               "gamma" = 0,
               "colsample_bytree" = 1,
               "min_child_weight" = 1,
               "num_class" = 3)

# early_stopping_rounds: This parameter specifies when to stop the training / algorithm. Setting it to 8 
# means that we're making the algorithm stop if there has not been an improvement in the test score (test-rmse) 
# for 8 rounds.

cv <- xgb.cv(   data = x
              , label = y
              , nfold = 5
              , nrounds = 100
              , early_stopping_rounds = 8
              , params = params)

# After running the above, we can see that our algoirthm will use test_mlogloss for early stopping and will 
# stop at ~20 iterations.

