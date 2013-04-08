context("geom_rect")

library(ggplot2)
df <- data.frame(x = 1:3, y = 1:3, label = c("a", "b", "c"))
df$x2 <- df$x + 0.5
df$y2 <- df$y + 0.5

base <- ggplot(df, aes(xmin = x, xmax = x2, ymin = y, ymax = y2))
base + geom_rect()
save_spec("geom/rect.js")

base + geom_rect(fill = "blue", colour = "red")
save_spec("geom/rect-params.js")

