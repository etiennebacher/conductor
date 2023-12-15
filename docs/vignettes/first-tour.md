# Your first tour

## A simple Shiny app

First, let’s create a simple Shiny app that will serve as a demo:

``` r
library(shiny)

ui <- fluidPage(
  actionButton("mybutton", "Test"),
  br(),
  div(class = "to-highlight", p("Hello, I'm the first p tag")),
  div(class = "to-highlight", p("Hi, I'm the second p tag"))
)

server <- function(input, output, session){}

shinyApp(ui, server)
```

## Create a conductor

Then, create a `Conductor` with:

``` r
library(conductor)

conductor <- Conductor$new()
```

This can be done anywhere, not necessarily in the `ui` or `server` parts
of the app. To add steps in the tour, use `$step()`. In each `$step()`,
you can specify a `title` and some `text`, along with other options that
will be detailed in other articles.

In each step, you can also define the argument `el`. This argument tells
`Conductor` which element should be highlighted. By default,
`el = NULL`, which means that steps will be displayed in the center of
the screen. The argument `el` can take several types of value:

-   an element id, e.g `#my-element`
-   an element class, e.g `.my-element`
-   a specific HTML tag, e.g `button`

If you use a class or a tag that is shared by several elements, only the
first one will be used.

``` r
conductor <- Conductor$
  new()$
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
```

!\> If the arguments in `$step()` are unnamed, they should follow the
order “title”, “text”, “el”.

## Call the conductor

Finally, call `useConductor()` in the `ui` and call
`conductor$init()$start()` anywhere in the `server`.

``` r
library(shiny)

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
