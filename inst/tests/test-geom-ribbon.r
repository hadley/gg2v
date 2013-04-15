context("geom_ribbon")
set.seed(1014)

library(ggplot2)
df <- data.frame(
  x = 1:10,
  x2 = sample(10),
  y = (-5:4) ^ 2,
  z = rep(1:3, length = 10))
df$z2 <- factor(df$z)

base <- ggplot(df, aes(x, ymin = y - 2, ymax = y + 2))

base + geom_ribbon()
save_spec("geom/ribbon.js")

base + geom_ribbon(fill = "red", colour = "blue", size = 3)
save_spec("geom/ribbon-params.js")
