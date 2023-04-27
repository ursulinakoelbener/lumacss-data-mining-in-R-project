###############################################################################
# PREPARATIONS
###############################################################################

library(tidyverse)
library(data.table)
library(ggplot2)
library(viridis) # Package for color palette

source(here::here("scripts", "02-access data_csv.R"))

###############################################################################
# CREATE PLOTS
###############################################################################

# Total Straftaten, unaufgeklärt oder aufgeklärt ----
# create dataset
df_plot1 <- df_strft %>% 
  filter(Straftat == "Straftat - Total") %>% 
  select(-Ausführungsgrad) %>% 
  group_by(Kanton, Jahr, Aufklärungsgrad) %>% 
  summarise(Anzahl = sum(Value)) %>% 
  ungroup()

# create plot ----
plot1 <- ggplot(data = df_plot1) +
  geom_line(mapping = aes(x = Jahr, y = Anzahl,
                          color = Aufklärungsgrad)) +
  facet_wrap(vars(Kanton), scales = "free") +
  labs(
    x = "Jahr",
    y = "Anzahl Straftaten",
    title = "Anzahl Polizeilich registrierte Straftaten nach Kanton und Aufklärungsgrad",
    subtitle = "",
    caption = "Quelle: Bundesamt für Statistik"
  ) +
  scale_color_viridis(discrete = TRUE)

# save plot
ggsave(here::here("figs", "plot1.png"), plot1)
            