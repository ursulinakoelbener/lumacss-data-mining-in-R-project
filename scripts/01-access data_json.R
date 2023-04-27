###############################################################################
# PREPARATIONS
###############################################################################

# install.packages("jsonlite")
# install.packages("tidyjson")
library(jsonlite)
library(tidyjson)
library(tidyverse)
library(stringr)

###############################################################################
# DATA STRUCTURE
###############################################################################

# access data from https://opendata.swiss/de/dataset/polizeilich-registrierte-straftaten-gemass-strafgesetzbuch-nach-kanton-ausfuhrungsgrad-und-aufk5
url <- "https://www.pxweb.bfs.admin.ch/api/v1/de/px-x-1903020100_101/px-x-1903020100_101.px"
# the actual data is missing (Number of crimes)

# convert from json
resp <- fromJSON(url)

# print names of variables
names(resp$variables)

# extract variable names ----

# extract the variables code from the resp list
variables_code <- resp$variables$code

# extract values for mapping table ----
# extract the variables 1 from the resp list
variables_1 <- resp$variables$values[[1]]

# extract the variables 2 from the resp list
variables_2 <- resp$variables$values[[2]]

# extract the variables 3 from the resp list
variables_3 <- resp$variables$values[[3]]

# extract the variables 4 from the resp list
variables_4 <- resp$variables$values[[4]]

# extract the variables 5 from the resp list
variables_5 <- resp$variables$values[[5]]

# extract text for mapping table ----
# extract the variables 1 from the resp list
text_1 <- resp$variables$valueTexts[[1]]

# extract the variables 2 from the resp list
text_2 <- resp$variables$valueTexts[[2]]

# extract the variables 3 from the resp list
text_3 <- resp$variables$valueTexts[[3]]

# extract the variables 4 from the resp list
text_4 <- resp$variables$valueTexts[[4]]

# extract the variables 5 from the resp list
text_5 <- resp$variables$valueTexts[[5]]

###############################################################################
# ACCESS DATA SET
###############################################################################
# access data from https://opendata.swiss/de/dataset/polizeilich-registrierte-straftaten-gemass-strafgesetzbuch-nach-kanton-ausfuhrungsgrad-und-aufk5
url_dat <- "https://www.pxweb.bfs.admin.ch/pxweb/de/px-x-1903020100_101/px-x-1903020100_101/px-x-1903020100_101.px"
# I was able to download a json file, but not to access it directly

# convert from json
resp_dat <- fromJSON(here::here("data", "px-x-1903020100_101_20230427-074952.json"))

# convert from json (only data from Appenzell Innerrhoden)
resp_dat_ai <- fromJSON(here::here("data", "px-x-1903020100_101_20230427-085854.json"))

# convert from json (only data from Appenzell Innerrhoden, only total)
resp_dat_ai_t <- fromJSON(here::here("data", "px-x-1903020100_101_20230427-090431.json"))

# now, it is a list object
class(resp_dat)

# view the data
resp_dat$dataset$dimension$Straftat$category$label
head(resp_dat)

# flatten the structure into a vector
resp_dat_vec <- unlist(resp_dat, recursive = TRUE, use.names = TRUE)

# working with tidyjson ----

# tidy the JSON data
resp_dat_tidy <- resp_dat %>% spread_all # not yet happy with the result

# another try
resp_dat %>% gather_object %>% json_types %>% count(name, type) # there are some object types

# enter an object
resp_dat %>% enter_object(dimension) %>% gather_object

# enter an object
resp_dat_ai %>% enter_object(status) %>% gather_object

# working only with toal from Appenzell Innerrhoden ----
# inspect response
resp_dat_ai_t %>% gather_object %>% json_types %>% count(name, type)

resp_dat_ai_t %>% enter_object(dimension) %>% gather_object
resp_dat_ai_t %>% enter_object(extension) %>% gather_object

# inspect all column names
resp_dat_ai_t %>% enter_object(dimension) %>% spread_all %>% colnames

df <- resp_dat_ai_t %>% spread_all

json_schema(resp_dat_ai_t)

df <- json_structure(resp_dat_ai_t)

resp_dat_ai_t %>% gather_object %>% append_values_number

