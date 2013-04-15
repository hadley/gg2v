\name{save_data}
\alias{plot_data}
\alias{save_data}
\title{Compute and save layer datasets for a ggplot2 plot.}
\usage{
  save_data(plot, path)

  plot_data(plot)
}
\arguments{
  \item{ggplot2}{plot}

  \item{path}{Existing directory in which to save plot
  datasets.}
}
\value{
  \code{save_data}: (invisibly) a list that can be
  transformed to JSON to produce vega data spec.
}
\description{
  Compute and save layer datasets for a ggplot2 plot.
}
\examples{
p1 <- ggplot(mtcars, aes(disp, cyl)) +
  geom_point()
str(plot_data(p1))

str(plot_data(p1 + geom_point(aes(y = cyl + 1))))

p2 <- p1 + geom_point(aes(displ * 61, cyl), data = mpg)
str(plot_data(p2))

p3 <- ggplot(mapping = aes(y = cyl)) +
  geom_point(aes(disp, colour = "mtcars"), data = mtcars) +
  geom_point(aes(displ * 61, colour = "mpg"), data = mpg)
str(plot_data(p3))

td <- temp_dir()
save_data(p3, td)
if (interactive()) show(td)
}

