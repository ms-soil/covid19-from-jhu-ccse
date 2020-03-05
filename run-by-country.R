


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