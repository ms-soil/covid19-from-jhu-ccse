# put in country name here:
library(tidyverse)
library(lubridate)
library(ggrepel)
library(gridExtra)
library(nls2)

source("get-data.R")

country <- "Germany"
source("run-by-country.R")

d3$country <- paste0(country)
d3$days <- seq(1:length(d3$date_readable))

c1 <- d3

p <- ggplot() +  
  theme_bw() +
  ggtitle("Corona cases (data from JHU CCSE)") +
  xlab("Date") +
  ylab("Confirmed cases") +
  geom_line(aes(c1$days, c1$cases),col = "red", size = 1) +
  geom_point(aes(c1$days, c1$cases),col = "black", size = 2) +
  geom_label_repel(aes(c1$days[c1$days == 45], 
                       c1$cases[c1$days == 45], 
                       label = c1$country[c1$days == 45]),
                   nudge_y = 20,
                   nudge_x = -4)
p

x <- c1$days
y <- c1$cases



fit <- nls(y ~ a^(x-b), start = list(a = 1.5, b = 10), algorithm = "port") # b is the starting point
# fit1 <- nls2(y ~ (0*x+d), start=list(d=500), algorithm="port")
summary(fit)

p + stat_function(fun = function(x) {1.355^(x-24.01832)}) 

c1$prediction <- 1.355 ^ (c1$days - 24.01832) 

p +
  geom_line(aes(c1$day, c1$prediction), col = "grey", size = 1, lty = 2)

# how many days are we at?
length(d3$days)
# 47 (Mar 8 - Sunday)

1.355 ^ (47 - 24.01832) 
1.355 ^ (48 - 24.01832) 
1.355 ^ (49 - 24.01832) 
1.355 ^ (50 - 24.01832) 

prediction_day_50_wed_mar_11 <- 1.355 ^ (50 - 24.01832) 
prediction_day_50_wed_mar_11
# 2679

prediction_day_54_sun_mar_15 <- 1.355 ^ (54 - 24.01832) 
prediction_day_54_sun_mar_15
# 9031

# #geschätzte Korrektur * 0.66
1.355 ^ (61 - 24.01832) 

