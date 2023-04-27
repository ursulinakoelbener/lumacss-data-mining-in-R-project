###############################################################################
# PREPARATIONS
###############################################################################

library(tidyverse)
library(data.table)

###############################################################################
# LOAD AND CLEAN DATA
###############################################################################

# load data
df <- fread(here::here("data", "px-x-1903020100_101_20230427-102332.csv"), header = TRUE)

# make data tidy
df_strft <- df %>% 
  mutate(`2021` = as.character(`2021`)) %>%
  mutate(`2022` = as.character(`2022`)) %>%
  pivot_longer(cols = c(`2009`, `2010`, `2011`, `2012`, `2013`, `2014`,`2015`, 
                        `2016`,`2017`, `2018`, `2019`, `2020`, `2021`, `2022`),
               names_to = "Jahr",
               values_to = "Value") %>%
  mutate(Value = as.numeric(Value)) %>% # change to numeric
  mutate(Jahr = as.numeric(Jahr)) # change to numeric
