
# install.packages("jsonlite")
library(tidyverse)
library(jsonlite)

# access data from https://opendata.swiss/de/dataset/polizeilich-registrierte-straftaten-gemass-strafgesetzbuch-nach-kanton-ausfuhrungsgrad-und-aufk5
url <- "https://www.pxweb.bfs.admin.ch/api/v1/de/px-x-1903020100_101/px-x-1903020100_101.px"

# convert from json
straftaten <- fromJSON(url)

# print names of variables
names(straftaten$variables)

# create a dataframe ----

# extract the variables code from the straftaten list
variables_code <- straftaten$variables$code

# extract the variables 1 from the straftaten list
variables_1 <- straftaten$variables$valueTexts[[1]]

# extract the variables 2 from the straftaten list
variables_2 <- straftaten$variables$valueTexts[[2]]

# extract the variables 3 from the straftaten list
variables_3 <- straftaten$variables$valueTexts[[3]]

# extract the variables 4 from the straftaten list
variables_4 <- straftaten$variables$valueTexts[[4]]

# extract the variables 5 from the straftaten list
variables_5 <- straftaten$variables$valueTexts[[5]]

# the actual data is missing (Number of crimes)

