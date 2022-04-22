# Tabs & navbar

Sometimes, you want the tour to navigate across tabs of a `tabsetPanel()` or a `navbarPage()`. This can be done with the arguments `tabId` and `tab`:

* `tabId` is the id of the `tabsetPanel()` or of the `navbarPage()`;
* `tab` is the id of the specific tab you want to navigate to.

?> It is best to specify `tabId` and `tab` on the steps just before and after switching tabs. For example, if you want step 1 to be on tab A and step 2 to be on tab B, you should specify `tabId` and `tab` on steps 1 and 2.

<!-- tabs:start -->

#### **Tabset**

```r
library(shiny)
library(conductor)

guide <- Conductor$
  new()$ 
  step(
    el = "#text",
    title = "This is a textInput.",
    text = "There is no need to specify tab and tabId on this step."
  )$
  step(
    el = "#text",
    title = "Text Input",
    text = "But this step is just before switching tabs so I should specify tab and tabId.",
    tab = "text_tab",
    tabId = "my_tabset"
  )$
  step(
    el = "#numeric",
    "This is a numericInput",
    "This step is on another tab.",
    tab = "numeric_tab",
    tabId = "my_tabset"
  )

ui <- fluidPage(
  useConductor(), # include dependencies
  h1("tabs"),
  tabsetPanel(
    id = "my_tabset",
    tabPanel("text_tab", textInput("text", "Text")),
    tabPanel("numeric_tab", numericInput("numeric", "Numeric", 0))
  )
)

server <- function(input, output){
  guide$init()$start()
}

shinyApp(ui, server)
```

#### **Navbar**

```r
library(shiny)
library(conductor)

home_guide <- Conductor$
  new()$
  step(
    el = "[data-value='home']",
    "You can select the tab itself",
    "Use the data-value attribute for this"
  )$
  step(
    el = ".p-home",
    text = "This is an element on tab 'Home'",
    tab = "home",
    tabId = "nav"
  )$
  step(
    el = ".p-about",
    text = "This is an element on tab 'About'",
    tab = "about",
    tabId = "nav"
  )

ui <- navbarPage(
  "conductor",
  header = list(useConductor()),
  id = "nav",
  tabPanel(
    "home",
    p(class = "p-home", "This is the tab 'Home'.")
  ),
  tabPanel(
    "about",
    p(class = "p-about", "This is the tab 'About'.")
  )
)

server <- function(input, output, session){
  home_guide$init()$start()
}

shinyApp(ui, server)
```


<!-- tabs:end -->
