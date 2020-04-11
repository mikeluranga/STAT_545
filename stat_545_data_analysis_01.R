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