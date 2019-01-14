## Data Visualization 

# Plotting data

# Below are some simple examples of how to plot a line in R, how to fit a line to some points, and how to add 
# more points to a graph.

# Make a very simply plot of (x, y) values and plot them:

x <- c(4, 6, 8, 11, 15, 18)
y <- c(2.8, 4.6, 6.2, 5.5, 7.8, 8.8)

plot(x, y)

# We can use a bunch of parameters to produce a more descriptive plot, as shown below:

plot(  x , y
     , xlab="X Axis Label"
     , ylab="Y Axis Label"
     , main = "Plot Title"
     , xlim = c(0, 20)     # X axis range
     , ylim = c(0, 10)     # Y axis range
     , pch = 4             # Set the plotting symbol to 'X'
     , col = "red"         # Set the plot color to red
     )

# Create a linear model and plot it:

lin_model <- lm(y ~ x)

abline(lin_model)

# Add more points to our graph:

x2 <- c(3.3, 6.6, 9.9, 13.2)
y2 <- c(1.6, 3.3, 5, 6.6 )

# Create a 2D line plot for the 4 new values:

points(  x2, y2
       , type="o"     # Use a line plot
       , col = "blue"
       )

# Histograms

# A histogram plots the frequencies that data appears within certain ranges. Below, we plot a simple histogram
# showing our mtcars data horse power distribution. 

data(mtcars)

hist(mtcars$hp, main = "Distribution of HP", xlab = "Horse Power")

# For our histogram, R will automatically calculate the intervals to use, although we can specify the amount of
# breaks we want using the breaks option:

hist(mtcars$hp, main = "Distribution of HP", xlab = "HP", breaks = 4)

# Boxplot

# A boxplot provides a graphical view of the median, quartiles, maximum, and minimum of a data set. 

boxplot(mtcars$mpg, main = "Boxplot for Miles per Gallon Data")

# We can also create a boxplot of a numerical variable grouped by a categorical variable

# Use the iris data set to create a boxplot of the sepal.length column grouped by species:

data(iris)

boxplot(Sepal.Length ~ Species, data = iris, main = "Boxplot of Sepal Length Grouped by Species")

# ggplot2

# ggplot is a popular visualization package which we can use to create elegant and complex plots.

# Let's illustrate some simple plots we can make using this library.

install_and_load_package('ggplot2')

# Create a regular dot plot of Sepal (length, width) points using our iris data:

ggplot( iris              
      , aes(x = Sepal.Length, y = Sepal.Width)) +   # Specify the aesthetic mappings (variable mappings)
        geom_point()  # Specify the geometric object. Here, we specify points (dots) to obtain a plot of points     

# Aesthetic mappings allow us to use properties within our data to influence the visual characeristics of our graphs.
# Lets make the same plot as above, except we will specify a different color for each flower species:

ggplot( iris              
      , aes(x = Sepal.Length, y = Sepal.Width, color = Species)) + 
        geom_point() 

# We can also make plots using different geometric shapes / objects. 

# Create a line chart for the iris data set:

ggplot( iris              
      , aes(x = Sepal.Length, y = Sepal.Width, color = Species)) + 
        geom_line()   

# Create a smoothed line chart:

ggplot( iris              
      , aes(x = Sepal.Length, y = Sepal.Width, color = Species)) + 
        geom_smooth() 

# Create a bar chart:

ggplot( data = iris          
      , aes(x = Sepal.Width)) + 
        geom_bar()              

# Create a histogram (which is similar to the bar chart above):

ggplot( data = iris          
      , aes(x = Sepal.Width)) + 
        geom_histogram()       

# Sometimes, we may want to display multiple plots in one image with the different facets. An advantage of 
# this method is that all axes share the same scale across the charts, making it easy to compare them at a glance.
# You can construct a plot with multiple facets by using the facet_wrap()

# Use the iris dataset and the facet_wrap function to plot the iris sepal width accross the different species:

ggplot( iris
      , aes(x = Sepal.Length, y = Sepal.Width)) + 
        geom_point() + 
        facet_wrap(~Species)

# Create a mew graph wiht added labels to our visuals using the labs function:

ggplot( iris
      , aes(x = Sepal.Length, y = Sepal.Width, color = Species)) +
        geom_point() +
        labs( title = "Width and Length Iris Data",
              subtitle = "Simple description of our data can be included here",
              x = "Sepal Length",
              y = "Sepal Width",
              color = "Species"
            )

# Use the facet_grid function to facet our data by more than one categorical variable:

data(mpg)

ggplot( mpg
      , aes(x = displ, y = hwy)) +
        geom_point() +
        facet_grid(year ~ cyl)  # Create a facet grid for year / cylinder data

# Time Series Data

# Time series data can be stored as a ts object. ts objects contain information about seasonal frequency that is used
# by ARIMA functions. It also allows for calling of elements in the series by date using the window command.

# Create a dummy dataset of 100 observations:

x <- rnorm(100)

# Convert this vector to a ts object with 100 annual observations:

x <- ts(x, start = c(1900), freq = 1)

plot(x)

# Convert this vector to a ts object with 100 monthly observations starting in July:

x <- ts(x, start = c(1900, 7), freq = 12)

plot(x)

# Exploratory Data Analysis with time-series data

# Lets load some air passanger data:

data(AirPassengers)

# Plot the raw data:

plot(AirPassengers) 

# Fit a trend line:

abline(reg=lm(AirPassengers~time(AirPassengers))) 

