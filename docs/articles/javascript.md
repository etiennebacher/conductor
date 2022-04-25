# Run custom JavaScript during the tour

There are several events occurring during a tour: the tour starts, is cancelled, is complete, etc. It is possible to run some JavaScript code during each of these events. Just like options, there are **tour events** and **step events**.

## Tour events

There are 7 tour events available: start, show, hide, cancel, complete, active, inactive. You can pass JS code at each of these events with the arguments starting with `on` in `$new()`. For example, let's say I want the page body to be red during the tour but white when the tour is not active. Then I can use `onStart` and `onShow` to make it red, and `onHide`, `onCancel` and `onComplete` to make it back to white:
```
library(shiny)
library(conductor)

bg_to_red = "document.body.style.background = 'red';"
bg_to_white = "document.body.style.background = 'white';"

conductor <- Conductor$
  new(
    onStart = bg_to_red,
    onShow = bg_to_red,
    onHide = bg_to_white,
    onCancel = bg_to_white,
    onComplete = bg_to_white
  )$
  step(
    title = "Hello there",
    text = "This popover is displayed in the center of the screen."
  )$
  step(
    "This is a button",
    "This button has no purpose. Its only goal is to serve as support for demo.",
    "#mybutton"
  )$
  step(
    ".to-highlight",
    title = "This is some text",
    text = "Only the first p tag is highlighted."
  )



ui <- fluidPage(
  useConductor(),
  actionButton("mybutton", "Test"),
  br(),
  div(class = "to-highlight", p("Hello, I'm the first p tag")),
  div(class = "to-highlight", p("Hi, I'm the second p tag"))
)

server <- function(input, output, session){
  conductor$init()$start()
  
}

shinyApp(ui, server)

```

## Step events

