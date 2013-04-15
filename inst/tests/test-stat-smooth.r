context("stat-smooth")
set.seed(1014)
library(ggplot2)
df <- data.frame(
  x = 1:10,
  y = (-5:4) ^ 2 + rnorm(10),
  z = factor(rep(1:2, each = 5)))

base <- ggplot(df, aes(x, y)) + geom_point()

base + geom_line(stat = "smooth")
save_spec("stat/smooth.js")

base + geom_line(stat = "smooth", method = "lm", formula = y ~ poly(x, 2))
save_spec("stat/smooth-lm.js")

base + geom_line(aes(group = z))
save_spec("stat/smooth-grouped.js")

base + geom_line(aes(colour = z))
save_spec("stat/smooth-colour.js")
