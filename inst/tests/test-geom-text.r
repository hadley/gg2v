context("geom: text")

df <- data.frame(x = 1:3, y = 1:3, label = c("a", "b", "c"))

base <- ggplot(df, aes(x, y, label = label))

base + geom_text()
save_spec("geom/text.js")

base + geom_text(fontface = "bold")
save_spec("geom/text-bold.js")

base + geom_text(fontface = "italic", colour = "red")
save_spec("geom/text-red-italic.js")

base + geom_text(aes(colour = label), fontface = "italic")
save_spec("geom/text-italic-col.js")
