library(shiny)

guide <- Docent$
  new(
    exitOnEsc = FALSE,
    keyboardNavigation = FALSE
  )$
  step(
    title = "Hello there"
  )$
  step(
    el = "test",
    title = "This is a button",
    text = "This button has no purpose. Its only goal is to serve as support for demo.",
    position = "bottom",
    can_click_target = FALSE,
    advance_on = list("#next_step", "click")
  )

ui <- fluidPage(
  useDocent(),
  actionButton("test", "Test"),
  actionButton("next_step", "Next step"),
  verbatimTextOutput("foo")
)

server <- function(input, output, session){
  guide$init()$start()

  output$foo <- renderText({
    guide$is_active()
    input$docent_is_active
  })
}

shinyApp(ui, server)
