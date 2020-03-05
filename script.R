library(tidyverse)
library(lubridate)

d <- read_csv("https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_19-covid-Confirmed.csv")
unique(d$`Country/Region`)

country <- "Germany"


d2 <- d %>% filter(`Country/Region` == country) %>% select(-`Province/State`, -`Lat`,-`Long`)

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
