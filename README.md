# gg2v

A quick and dirty experiment exploring rendering ggplot2 graphics using vega.  

This approach uses relatively little existing ggplot2 code, and the semantics may be slightly different. It is likely to converge over time as both vega and gg2v become more mature, but there's no expectation that ggplot2 and gg2v will ever be exactly concordances.  It's probably easier to think of gg2v as an alternative specification and rendering of the graphics DSL defined by ggplot2.

Please note that this is an __experimental prototype__, and is unlikely to be maintained long-term (unless someone else volunteers). 
# Currently supported

* scales: 
  * x and y position scales (continuous and categorical)
  * colour gradients
  * limited support for categorical colours
* geoms: point, line, path, area
* stats: none
* facets: none
* position adjustments: none