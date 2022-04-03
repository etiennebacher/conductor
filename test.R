library(shiny)

guide <- Docent$new()$
  step(
    title = "Hello there"
  )$
  step(
    el = "test",
    title = "This is a button",
    text = "This button has no purpose. Its only goal is to serve as support for demo.",
    position = "bottom",
    can_click_target = FALSE
  )

ui <- fluidPage(
  useDocent(),
  actionButton("test", "Test")
)

server <- function(input, output){
  guide$init()$start()
}

shinyApp(ui, server)
