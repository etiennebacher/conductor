library(shiny)
library(lorem) # gadenbuie/lorem

x = 0.6
guide <- Conductor$
  new(
    mathjax = TRUE,
    defaultStepOptions = list(
      cancelIcon = list(
        enabled = FALSE,
        label = "foo"
      )
    )
  )$
  step(
    title = "hello welcome on this tour bla blabla bla bla bla",
    # title = 'The busy Cauchy distribution
    #            $$\\frac{1}{\\pi\\gamma\\,\\left[1 +
    #            \\left(\\frac{x-x_0}{\\gamma}\\right)^2\\right]}\\!$$',
    text = 'You do not see me initially: $$e^{i \\pi} + 1 = 0$$',
    showOn = TRUE
  )$
  step(
    el = "#summary",
    text = "hi",
    position = "bottom",
    tabId = "tabz",
    tab = "Plot"
  )$
  step(
    el = "#summary",
    title = "This is a button $$\\frac{1}{\\pi\\gamma\\,\\left[1 +
               \\left(\\frac{x-x_0}{\\gamma}\\right)^2\\right]}\\!$$",
    text = ipsum_words(30),
    position = "bottom",
    canClickTarget = FALSE,
    showOn = x < 0.5
  )

ui <- fluidPage(
  tags$head(
    withMathJax(),
    useConductor(),
    tags$style(
      HTML(".longdiv {height: 100vh}")
    )
  ),
  tabsetPanel(
    id = "tabz",
    tabPanel("plot_tab", h2("show plot here", id = "plot")),
    tabPanel("Plot", h2("show summary here", id = "summary"))
  )
)

server <- function(input, output, session){
  guide$init()$start()

  output$foo <- renderText({
    guide$isActive()
  })

  # observe({
  #   if (!isTRUE(guide$isActive())) {
  #     showModal(modalDialog(
  #       title = "Important message",
  #       "This is an important message!"
  #     ))
  #   }
  # })
}

shinyApp(ui, server)
