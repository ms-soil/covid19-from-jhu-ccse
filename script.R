# put in country name here:
library(tidyverse)
library(lubridate)
library(ggrepel)

source("get-data.R")

country1 <- "Germany"
country2 <- "Austria"
country3 <- "Switzerland"

country <- country1
source("run-by-country.R")
d3$country <- paste0(country)
assign(paste0(country,"_data"), d3)
c1 <- d3

p <- ggplot() +  
  theme_bw() +
  ggtitle("Corona cases (data from JHU CCSE)") +
  xlab("Date") +
  ylab("Confirmed cases") +
  geom_line(aes(c1$date_readable, c1$cases),col = "red", size = 1) +
  geom_point(aes(c1$date_readable, c1$cases),col = "black", size = 2) +
  geom_label_repel(aes(c1$date_readable[c1$date_readable == "2020-03-02"], 
                       c1$cases[c1$date_readable == "2020-03-02"], 
                       label = c1$country[c1$date_readable == "2020-03-02"]),
                   nudge_y = 20,
                   nudge_x = -4)
#p

country <- country2
source("run-by-country.R")
d3$country <- paste0(country)
assign(paste0(country,"_data"), d3)
c2 <- d3

p <- p +
  geom_line(aes(c2$date_readable, c2$cases),col = "blue", size = 1) +
  geom_point(aes(c2$date_readable, c2$cases),col = "black", size = 2) +
  geom_label_repel(aes(c2$date_readable[c2$date_readable == "2020-03-02"], 
                       c2$cases[c2$date_readable == "2020-03-02"], 
                       label = c2$country[c2$date_readable == "2020-03-02"]),
                   nudge_y = 20,
                   nudge_x = -4)
#p

country <- country3
source("run-by-country.R")
d3$country <- paste0(country)
assign(paste0(country,"_data"), d3)
c3 <- d3

p <- p +
  geom_line(aes(c3$date_readable, c3$cases),col = "orange", size = 1) +
  geom_point(aes(c3$date_readable, c3$cases),col = "black", size = 2) +
  geom_label_repel(aes(c3$date_readable[c3$date_readable == "2020-03-02"], 
                       c3$cases[c3$date_readable == "2020-03-02"], 
                       label = c3$country[c3$date_readable == "2020-03-02"]),
                   nudge_y = 20,
                   nudge_x = -4)
p


ggsave(paste0("plots/plot_",country1,"_",country2,"_",country3,".png"), p)  

