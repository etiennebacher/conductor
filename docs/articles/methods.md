# Methods

There are several available methods, that you can call with `$<method>()`: 

* edit the tour/step: `show()`, `hide()`, `remove()`, `cancel()`, `moveBack()`, `moveNext()`;
* get information on the tour/step: `getCurrentStep()`, `getHighlightedElement()`, `isActive()`, `isOpen()`, `isCentered()`.

Below are some examples for some of these methods.

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

## Remove specific steps

You may want to have different versions of your tour. For example, you could adapt your tour depending on the skill level of the user.

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
    el = "#show",
    title = "This is a button",
    text = "This should be displayed to novice only.",
    id = "novice1"
  )$
  step(
    title = "Do you have questions?",
    text = "This should be displayed to novice only.",
    id = "novice2"
  )$
  step(
    el = "#show",
    text = "We just skipped the two novice steps.",
  )

ui <- fluidPage(
  useConductor(),
  selectInput("choose_tour", "Choose your level", choices = c("novice", "experienced")),
  actionButton("show", "Run tour")
)

server <- function(input, output, session){
  
  conductor$init()
  
  observeEvent(input$choose_tour, {
    if (input$choose_tour == "experienced") {
      conductor$remove(step = c("novice1", "novice2"))
    } else {
      conductor$init()
    }
  })
  
  observeEvent(input$show, {
    conductor$start()
  })
}

shinyApp(ui, server)
```

## Move to previous/next steps

This can be useful if you want to programmatically move to the previous/next step, for example by showing a series of popovers while a slow computation is taking place.

```r
library(shiny)
library(conductor)

guide <- Conductor$new()$
  step(
    "hello welcome on this tour",
    "This is the content of the modal"
  )$
  step(
    "This is the second step"
  )

ui <- fluidPage(
  useConductor()
)

server <- function(input, output, session){
  guide$init()$start()
  while(TRUE) {
    Sys.sleep(3)
    guide$moveNext()
    Sys.sleep(3)
    guide$moveBack() 
  }
}

shinyApp(ui, server)
```

## Get the id of the current step

I don't have specific usecase but it's here if needed:

```r
library(shiny)
library(conductor)

guide <- Conductor$new()$
  step(
    "hello welcome on this tour",
    "This is the content of the modal",
    position = "right",
    id = "step1"
  )$
  step("hi", id = "step2")

ui <- fluidPage(
  useConductor(),
  textOutput("test")
)

server <- function(input, output, session){
  guide$init()$start()
  
  output$test <- renderText({
    guide$getCurrentStep()
  })
}

shinyApp(ui, server)
```
