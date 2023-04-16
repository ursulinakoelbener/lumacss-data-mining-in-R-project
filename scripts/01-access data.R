
# install.packages("jsonlite")
library(tidyverse)
library(jsonlite)

# access data from https://opendata.swiss/de/dataset/polizeilich-registrierte-straftaten-gemass-strafgesetzbuch-nach-kanton-ausfuhrungsgrad-und-aufk5
url <- "https://www.pxweb.bfs.admin.ch/api/v1/de/px-x-1903020100_101/px-x-1903020100_101.px"

# convert to json
straftaten <- fromJSON(url)

# print names of variables
names(straftaten$variables)

df_straft <- list()

for(i in length(straftaten)){
  df_straft[[i]] <- straftaten$variables$text
}
