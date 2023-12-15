# Buttons

It is possible to specify the buttons on the popover. This can be done
for each step one by one, but it is also possible to define “default
buttons” that will be applied to all steps.

Let’s start with buttons for a specific step. By default, buttons
“Previous” and “Next” are put on every popover, but maybe you only want
the button “Next” on the first step and maybe you want to rename “Next”
as “Finish” on the last step.

``` r
library(shiny)
library(conductor)

guide <- Conductor$new()$
  step(
    el = "#foo",
    "hello welcome on this tour",
    buttons = list(
      list(
        action = "next",
        text = "Next"
      )
    )
  )$
  step("Second step")$
  step(
    "End of the tour",
    buttons = list(
      list(
        action = "back",
        secondary = TRUE,
        text = "Previous"
      ),
      list(
        action = "next",
        text = "Finish"
      )
    )
  )

ui <- fluidPage(
  useConductor(),
  textInput("foo", "foo")
)

server <- function(input, output, session){
  guide$init()$start()
}

shinyApp(ui, server)
```

Note that the argument `buttons` is a nested list: there is one big list
that contains several “sublists”, one for each button. In each
“sublist”, there are six possible arguments: \* action: either “back” or
“next”; \* text: the name of the button; \* secondary: a boolean
indicating whether the class “secondary” should be applied; \* disabled:
a boolean indicating whether the button should be disabled; \* label:
aria-label for the button; \* classes: extra classes to give to the
button for more CSS customization.

You can also modify the default buttons (e.g buttons visible on step 2
on the example above). This can be done by specifying `buttons` in
`defaultStepOptions` in `$new()`. For example:

``` r
guide <- Conductor$new(
  defaultStepOptions = list(
    buttons = list(
      list(
        action = "back",
        secondary = TRUE,
        text = "PREVIOUS"
      ),
      list(
        action = "next",
        text = "NEXT"
      )
    )
  )
)$
  step(
    el = "#foo",
    "hello welcome on this tour",
    buttons = list(
      list(
        action = "next",
        text = "NEXT"
      )
    )
  )$
  step("Second step")$
  step(
    "End of the tour",
    buttons = list(
      list(
        action = "back",
        secondary = TRUE,
        text = "PREVIOUS"
      ),
      list(
        action = "next",
        text = "FINISH"
      )
    )
  )
```
