# Misc

## HTML formatting 

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

## Show a specific step

You can use `$show()` to display a specific step. This requires specifying either a step number or a step id (that you can define with `id` in each `$step()`).

```r
library(shiny)
library(conductor)

conductor <- Conductor$
  new()$
  step(
    el = "#show",
    title = "This is a button",
    text = "This button has no purpose. Its only goal is to serve as support for demo."
  )$
  step(
    el = "#show",
    text = "This is the second step.",
    id = "second_step"
  )

ui <- fluidPage(
  useConductor(),
  actionButton("show", "Show the second step")
)

server <- function(input, output, session){
  
  conductor$init()
  
  observeEvent(input$show, {
    conductor$show(step = 2)
    # also works
    # conductor$show(step = "second_step")
  })
}

shinyApp(ui, server)
```
