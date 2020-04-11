library(tidyverse)
library(gapminder)

str(gapminder)

## see? it's still a regular data frame, but also a tibble
class(gapminder)

gapminder

head(gapminder)
tail(gapminder)
as_tibble(iris)

names(gapminder)
ncol(gapminder)
length(gapminder)
dim(gapminder)
nrow(gapminder)

summary(gapminder)

plot(lifeExp ~ year, gapminder)

plot(lifeExp ~ gdpPercap, gapminder)

plot(lifeExp ~ log(gdpPercap), gapminder)


head(gapminder$lifeExp)
summary(gapminder$lifeExp)
hist(gapminder$lifeExp)

summary(gapminder$year)
table(gapminder$year)

class(gapminder$continent)
summary(gapminder$continent)
levels(gapminder$continent)
nlevels(gapminder$continent)
str(gapminder$continent)


table(gapminder$continent)
barplot(table(gapminder$continent))

## we exploit the fact that ggplot2 was installed and loaded via the tidyverse
p <- ggplot(filter(gapminder, continent != "Oceania"),
            aes(x = gdpPercap, y = lifeExp)) # just initializes
p <- p + scale_x_log10() # log the x axis the right way
p + geom_point() # scatterplot
p + geom_point(aes(color = continent)) # map continent to color
p + geom_point(alpha = (1/3), size = 3) + geom_smooth(lwd = 3, se = FALSE)
#> `geom_smooth()` using method = 'gam' and formula 'y ~ s(x, bs = "cs")'
p + geom_point(alpha = (1/3), size = 3) + facet_wrap(~ continent) +
  geom_smooth(lwd = 1.5, se = FALSE)
#> `geom_smooth()` using method = 'loess' and formula 'y ~ x'


#Use of filter instead of subsetting

filter(gapminder, lifeExp < 29)
filter(gapminder, country == "Rwanda", year > 1979)
filter(gapminder, country %in% c("Rwanda", "Afghanistan"))

#Pipes

gapminder %>%
  filter(country == "Cambodia") %>%
  select(year, lifeExp)


(my_gap <- gapminder)

## let output print to screen, but do not store
my_gap %>% filter(country == "Canada")


#Use mutate() to add new variables
my_gap %>%
  mutate(gdp = pop * gdpPercap)


ctib <- my_gap %>%
  filter(country == "Canada")
## this is a semi-dangerous way to add this variable
## I'd prefer to join on year, but we haven't covered joins yet
my_gap <- my_gap %>%
  mutate(tmp = rep(ctib$gdpPercap, nlevels(country)),
         gdpPercapRel = gdpPercap / tmp,
         tmp = NULL)

my_gap %>% 
  filter(country == "Canada") %>% 
  select(country, year, gdpPercapRel)

summary(my_gap$gdpPercapRel)

#arrange

my_gap %>%
  filter(year == 2007) %>%
  arrange(desc(lifeExp))
