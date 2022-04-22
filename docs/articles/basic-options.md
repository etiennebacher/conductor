# Basic options

There are two types of options: tour options and step options.

## Tour options

Tour options are options that will be applied to every step. They are specified when the tour is created with `$new()`. The most useful tour options are the following (the default value is between parenthesis):

* `exitOnEsc`: allow leaving the tour by pressing "Esc" (`TRUE`) 
* `keyboardNavigation`: allow navigating the tour with keyboard arrows (`TRUE`)
* `useModalOverlay`: darken the background to highlight the step and the element (`TRUE`)
* `mathjax`: enable MathJax (`FALSE`). This requires importing MathJax dependencies, for example with `shiny::withMathJax()`.

Here's an example with these options:
```r
library(shiny)
library(conductor)

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
    el = "#test",
    title = "This is a button",
    text = "This button has no purpose. Its only goal is to serve as support for demo."
  )$
  step(
    el = "#test",
    title = "An alternative text"
  )

ui <- fluidPage(
  useConductor(),
  actionButton("test", "Test")
)

server <- function(input, output, session){
  conductor$init()$start()
}

shinyApp(ui, server)
```

There are more options available, for example to give a prefix to the tour classes so that you can give different styles to different tours. The full list of tour options is available with `?conductor::Conductor`, at "Method new()".


## Step options

Step options are defined in each `$step()` and will be applied to one step only. The most useful ones are (default value between parenthesis):

* `position`: where the popover should appear relative to the element (`auto`)
* `arrow`: show an arrow pointing towards the element (`TRUE`)
* `cancelIcon`: a list of two elements: `enabled` is a boolean indicating whether a "close" icon should be displayed (default is TRUE); `label` is the label to add for aria-label (`NULL`).

```r
library(shiny)
library(conductor)

conductor <- Conductor$
  new()$
  step(
    title = "Hello there",
    text = "This popover is displayed in the center of the screen."
  )$
  step(
    el = "#test",
    title = "This is a button",
    text = "As specified, there is no arrow poiting towards this button.",
    arrow = FALSE
  )$
  step(
    el = "#myplot",
    title = "This is a plot",
    text = "It represents the iris dataset",
    cancelIcon = list(enabled = TRUE, label = "Close"),
    position = "top-start"
  )


ui <- fluidPage(
  useConductor(),
  actionButton("test", "Test"),
  div(style = "height: 50vh"),
  plotOutput("myplot")
)

server <- function(input, output, session){
  conductor$init()$start()
  
  output$myplot <- renderPlot(plot(iris))
}

shinyApp(ui, server)
```

The full list of step options is available with `?conductor::Conductor`, at "Method step()".

?> If you want to apply some step options to every step, you can use `defaultStepOptions` in `$new()`. For example, if you want to add a cancel icon to all steps, you can do:
```r
Conductor$
  new(
    defaultStepOptions = list(
      cancelIcon = list(enabled = TRUE, NULL)
    )
  )
```

## Misc

You can use HTML tags to format the `title` and `text` of `$step()`:

```r
library(shiny)
library(conductor)

conductor <- Conductor$
  new()$
  step(
    "Format with HTML tags",
    "<b>This is in bold.</b><em>This is in italics.</em><p style = 'color: red'>This is in red.</p>"
  )

ui <- fluidPage(
  useConductor()
)

server <- function(input, output, session){
  conductor$init()$start()
}

shinyApp(ui, server)
```
