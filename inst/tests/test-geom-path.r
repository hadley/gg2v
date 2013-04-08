context("geom_path")

library(ggplot2)
df <- data.frame(
  x = 1:10,
  y = (-5:4) ^ 2,
  z = rep(1:3, length = 10))
df$z2 <- factor(df$z)

base <- ggplot(df, aes(x, y))

base + geom_path()
save_spec("geom/path.js")

base + geom_path(aes(group = z))
save_spec("geom/path-group.js")

base + geom_path(aes(group = z, colour = z))
save_spec("geom/path-group-colour.js")

base + geom_path(aes(colour = z2))
save_spec("geom/path-colour.js")

base +
  geom_path(aes(colour = z2)) +
  geom_point()
save_spec("geom/path-colour-point.js")

