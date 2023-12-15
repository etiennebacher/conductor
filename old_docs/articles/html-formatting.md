# HTML formatting 

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
