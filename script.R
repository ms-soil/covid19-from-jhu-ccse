# put in country name here:
country <- "Iran"

library(tidyverse)
library(lubridate)

d <- read_csv("https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_19-covid-Confirmed.csv") %>% 
  group_by(`Country/Region`) %>% summarize(`1/22/20` = sum(`1/22/20`),
                                           `1/23/20` = sum(`1/23/20`),
                                           `1/24/20` = sum(`1/24/20`),
                                           `1/25/20` = sum(`1/25/20`),
                                           `1/26/20` = sum(`1/26/20`),
                                           `1/27/20` = sum(`1/27/20`),
                                           `1/28/20` = sum(`1/28/20`),
                                           `1/29/20` = sum(`1/29/20`),
                                           `1/30/20` = sum(`1/30/20`),
                                           `1/31/20` = sum(`1/31/20`),
                                           `2/1/20` = sum(`2/1/20`),
                                           `2/2/20` = sum(`2/2/20`),
                                           `2/3/20` = sum(`2/3/20`),
                                           `2/4/20` = sum(`2/4/20`),
                                           `2/5/20` = sum(`2/5/20`),
                                           `2/6/20` = sum(`2/6/20`),
                                           `2/7/20` = sum(`2/7/20`),
                                           `2/8/20` = sum(`2/8/20`),
                                           `2/9/20` = sum(`2/9/20`),
                                           `2/10/20` = sum(`2/10/20`),
                                           `2/11/20` = sum(`2/11/20`),
                                           `2/12/20` = sum(`2/12/20`),
                                           `2/13/20` = sum(`2/13/20`),
                                           `2/14/20` = sum(`2/14/20`),
                                           `2/15/20` = sum(`2/15/20`),
                                           `2/16/20` = sum(`2/16/20`),
                                           `2/17/20` = sum(`2/17/20`),
                                           `2/18/20` = sum(`2/18/20`),
                                           `2/19/20` = sum(`2/19/20`),
                                           `2/20/20` = sum(`2/20/20`),
                                           `2/21/20` = sum(`2/21/20`),
                                           `2/22/20` = sum(`2/22/20`),
                                           `2/23/20` = sum(`2/23/20`),
                                           `2/24/20` = sum(`2/24/20`),
                                           `2/25/20` = sum(`2/25/20`),
                                           `2/26/20` = sum(`2/26/20`),
                                           `2/27/20` = sum(`2/27/20`),
                                           `2/28/20` = sum(`2/28/20`),
                                           `2/29/20` = sum(`2/29/20`),
                                           `3/1/20` = sum(`3/1/20`),
                                           `3/3/20` = sum(`3/2/20`))

# add new dates in list above when available

length(d$`Country/Region`)
unique(d$`Country/Region`)

identical(d$`Country/Region`, unique(d$`Country/Region`))



d2 <- d %>% filter(`Country/Region` == country) # %>% select(-`Province/State`, -`Lat`,-`Long`)

d2[2,] <- d2[1,]
d2[1,] <- names(d2)
names(d2) <- seq(1:length(names(d2)))
#View(d2)

d3 <- data.frame(t(d2))[-1,]
names(d3) <- c("date", "cases")
d3$cases <- as.character(d3$cases)
d3$cases <- as.numeric(d3$cases)
range(d3$cases)
d3$date_readable <- format(mdy(d3$date), "%Y-%m-%d")
d3$date_readable <- as_date(d3$date_readable)
str(d3)

#View(d3)

p <- d3 %>% ggplot(aes(date_readable, cases)) +
  geom_line(col = "red", size = 1) +
  geom_point(col = "black", size = 2) +
  theme_bw() +
  ggtitle(paste0(country, " - Corona cases (data from JHU CCSE)")) +
  xlab("Date") +
  ylab("Confirmed cases")
p

ggsave(paste0("plots/plot_",country,".png"), p)  
