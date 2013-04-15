\name{gg2v}
\alias{gg2v}
\alias{gg2v-package}
\title{Render a ggplot2 graphic with vega.}
\usage{
  gg2v(base_path = ".", plot = last_plot(), name = "test",
    ..., debug = TRUE)
}
\arguments{
  \item{plot}{ggplot2 graphic}

  \item{base_path}{path in which to save all visualisation
  files.  Must already exist.}

  \item{name}{name of visualisation. Used to name html and
  js spec files}

  \item{...}{other arguments passed on to
  \code{\link{plot_spec}}}

  \item{debug}{if \code{TRUE} embeds spec in file and uses
  svg renderer, which makes the plot easier to debug}
}
\description{
  Render a ggplot2 graphic with vega.
}
\section{Use}{
  This function creates all the files necesary to render a
  vega visualisation: but currently you're responsible for
  running a server to send them to the browser.  You can't
  run directly from disk (with a \code{file://}) url,
  because browser security settings make it impossible to
  load data from relative urls.
}

