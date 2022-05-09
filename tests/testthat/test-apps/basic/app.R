library(shiny)
library(conductor)

guide <- Conductor$new()$
  step(
    el = "#foo",
    "hello welcome on this tour",
    "This is the content of the modal",
    position = "right",
    id = "step1"
  )$
  step("hi", id = "step2")$
  step(
    el = "#foo2",
    "This is the content of the modal",
    position = "right",
    id = "step3"
  )

ui <- fluidPage(
  useConductor(),
  textInput("foo", "foo"),
  textInput("foo2", "foo2"),
  textOutput("test")
)

server <- function(input, output, session){
  guide$init()$start()
}

shinyApp(ui, server)
