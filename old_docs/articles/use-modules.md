# Use `conductor` in modules

Using [Shiny modules](https://shiny.rstudio.com/articles/modules.html) is common in large Shiny apps. In modules, input names must be wrapped in `ns()` to avoid namespace collision.

To use `conductor` with inputs defined in modules, you can first define your `Conductor` outside of the app and then use `$step()` in the server part of the module, while still wrapping the `el` argument in `ns()`:

```r
library(shiny)
library(conductor)

guide <- Conductor$new()$
  step(
    title = "hello there"
  )

# First module

mod_num_ui <- function(id){
  ns <- NS(id)
  numericInput(ns("num"), label = "Enter a number", value = 5, min = 0, max = 10)
}

mod_num_server <- function(input, output, session){
  ns <- session$ns
  guide$
    step(
      el = ns("num"), # use namespace
      title = "Step 1",
      text = "This is a numericInput."
    )
}

# Second module

mod_text_ui <- function(id){
  ns <- NS(id)
  textInput(ns("text"), label = "Type some text")
}

mod_text_server <- function(input, output, session){
  ns <- session$ns
  guide$
    step(
      el = ns("text"),
      title = "Step 2",
      text = "This is a textInput."
    )
}

# Main app 

ui <- fluidPage(
  useConductor(),
  mod_num_ui("num1"),
  mod_text_ui("text1")
)

server <- function(input, output, session){
  
  callModule(mod_num_server, "num1")
  callModule(mod_text_server, "text1")
  
  # launch after module called
  guide$init()$start()
}

shinyApp(ui = ui, server = server)
```
