# Compare eval vs. [[

library(microbenchmark)
options(digits = 2)

microbenchmark(
  mtcars[["mpg"]],
  mtcars[["carb"]],
  eval(quote(mpg), mtcars),
  eval(quote(carb), mtcars),
  .subset2(mtcars, "mpg"),
  .subset2(mtcars, "carb")
)

# [[  =      8000 ns
# eval =     2000
# .subset2 =  400
