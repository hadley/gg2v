context("geom_smooth")

library(ggplot2)
df <- data.frame(
  x = 1:10,
  y = (-5:4) ^ 2)

base <- ggplot(df, aes(x, y))

base + geom_smooth(aes(ymin = y - 2, ymax = y + 2), stat = "identity")
save_spec("geom/smooth.js")

base + geom_smooth()
save_spec("geom/smooth-auto.js")
