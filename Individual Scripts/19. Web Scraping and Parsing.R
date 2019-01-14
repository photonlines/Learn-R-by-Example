## Web Scraping and Parsing

# rvest is a package for web scraping and parsing by Hadley Wickham inspired by Python's Beautiful Soup. It
# leverages Hadley's xml2 package's libxml2 bindings for HTML parsing.

# To scrape the table of R milestones from the Wikipedia page on R, the code would look like:

install_and_load_package('rvest')

url <- 'https://en.wikipedia.org/wiki/R_(programming_language)'

# Scrape HTML from website and use pipe operators to transform it into a data frame:

url %>%
  # Read the url html:
  read_html() %>%
  # Select HTML tag with class="wikitable":
  html_node(css = '.wikitable') %>%
  # Parse table into data.frame:
  html_table() %>%
  # Trim the description to 100 characters for printing:
  dplyr::mutate(Description = substr(Description, 1, 100))

