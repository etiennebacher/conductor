<img src="README_assets/hex-conductor.png" id="hex-conductor" align="right">

# conductor

<!-- badges: start -->
[![R-CMD-check](https://github.com/etiennebacher/conductor/workflows/R-CMD-check/badge.svg)](https://github.com/etiennebacher/conductor/actions)
<!-- badges: end -->

Create tours in Shiny apps using [shepherd.js](https://shepherdjs.dev/).

## Installation

You can install the development version of `conductor` from [GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("etiennebacher/conductor")
```

## How to use 

If you already use [`cicerone`](https://github.com/JohnCoene/cicerone), then you should be able to use `conductor` quite easily. 

### Create a conductor

First, create a `Conductor` with:
```r
library(conductor)

conductor <- Conductor$new()
```
This can be done anywhere, not necessarily in the `ui` or `server` parts of the app. You can also add some options in `$new()`. To add steps in the tour, use `$step()`. Steps can be attached to specific elements with `el`, but if no `el` is specified then the popover will be displayed in the center of the screen.
```r
conductor <- Conductor$
  new(
    exitOnEsc = FALSE,
    keyboardNavigation = FALSE
  )$
  step(
    title = "Hello there",
    text = "This popover is displayed in the center of the screen."
  )$
  step(
    el = "test",
    title = "This is a button",
    text = "This button has no purpose. Its only goal is to serve as support for demo."
  )
```

### Call the conductor

Then, call `useConductor()` in the `ui` and call `conductor$init()$start()` anywhere in the `server`.

```r
library(shiny)

ui <- fluidPage(
  useConductor(),
  actionButton("test", "Test")
)

server <- function(input, output, session){
  conductor$init()$start()
}

shinyApp(ui, server)
```

## Similar packages

This is not at all the first package to enable tours in Shiny applications. Similar packages are:

* [`rintrojs`](https://github.com/carlganz/rintrojs)
* [`cicerone`](https://github.com/JohnCoene/cicerone)

## Acknowledgements

The structure of the package, the code and the docs of `conductor` are copied or largely inspired from [`cicerone`](https://github.com/JohnCoene/cicerone), by [John Coene](https://john-coene.com/).

