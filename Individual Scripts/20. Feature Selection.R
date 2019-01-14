## Feature Selection

# Feature selection is about removing extraneous features / data cleaning.

# A feature that has near zero variance is a good candidate for removal. You can manually detect numerical 
# variance below your own threshold:

data(iris)

variances <- apply(iris, 2, var)

variances[which(variances <= 0.0025)]    # returns character(0)

# Or, you can use the caret package to find near zero variance:

install_and_load_package('caret') 

names(iris)[nearZeroVar(iris)]         # returns character(0)

# Removing features with high numbers of NA. If a feature is largely lacking data, it is a good candidate 
# for removal:

install_and_load_package('VIM')

# Load the sleep data:

data(sleep)

# Use the colMeans and is.na functions to find the ratio of missing values for each column

colMeans( is.na(sleep) )
#    BodyWgt   BrainWgt       NonD      Dream     Sleep        Span       Gest
# 0.00000000 0.00000000 0.22580645 0.19354839 0.06451613 0.06451613 0.06451613

# In the above case, we may want to remove NonD and Dream, which have around 20% of their values missing 

# To drop columns, there's the subset command, which we could use as demonstrated below:

sleep_with_missing_col <- subset(sleep, select = -c(NonD, Dream))

# Or we can use regular frame filtering and %in% operator:

columns_to_drop <- c("NonD", "Dream")

sleep_with_missing_col <- sleep[ , !(names(sleep) %in% columns_to_drop)]

# Removing Closely Correlated Features

# Closely correlated features may add variance to your model, and removing one of a correlated pair might help
# reduce that. There are lots of ways to detect correlation. Here's one:

install_and_load_package('purrr') 

# Select correlatable vars (numeric ones)

to_correlate <- mtcars %>% keep ( is.numeric )

# Calculate correlation matrix

correlation_matrix <- cor(to_correlate)

correlation_matrix

# Pick only one out of each highly correlated pair's mirror image

correlation_matrix[upper.tri(correlation_matrix)] <- 0

# We don't remove the highly-correlated-with-itself group

diag(correlation_matrix) <- 0

# Find features that are highly correlated with another feature at the +- 0.85 level

apply(correlation_matrix, 2, function(x) any( abs(x) >= 0.85 ) )
#  mpg   cyl  disp    hp  drat    wt  qsec    vs    am  gear  carb 
# TRUE  TRUE  TRUE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE 

# We'll want to look at what MPG is correlated to so strongly, and decide what to keep and what to toss. 
# Same for cyl and disp. Alternatively, we might need to combine some strongly correlated features.

