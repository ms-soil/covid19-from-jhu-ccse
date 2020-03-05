# put in country name here:
library(tidyverse)
library(lubridate)

country <- "US"
source("run-by-country.R")
assign(paste0(country,"_data"), d3)


p <- ggplot() +  
  theme_bw() +
  ggtitle(paste0(country, " - Corona cases (data from JHU CCSE)")) +
  xlab("Date") +
  ylab("Confirmed cases") +
  geom_line(aes(get(paste0(country,"_data"))$date_readable, get(paste0(country,"_data"))$cases),col = "red", size = 1) +
  geom_point(aes(get(paste0(country,"_data"))$date_readable, get(paste0(country,"_data"))$cases),col = "black", size = 2)
p

country <- "Germany"
source("run-by-country.R")
assign(paste0(country,"_data"), d3)

p <- p +
  geom_line(aes(get(paste0(country,"_data"))$date_readable, get(paste0(country,"_data"))$cases),col = "blue", size = 1) +
  geom_point(aes(get(paste0(country,"_data"))$date_readable, get(paste0(country,"_data"))$cases),col = "black", size = 2)
p

ggsave(paste0("plots/plot_",country,".png"), p)  


US_data
