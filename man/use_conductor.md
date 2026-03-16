

# Dependencies

[**Source code**](https://github.com/etiennebacher/conductor/tree/8231dd1f7caab11ca8cb0fa45376dd906d8e3805/R/conductor.R#L23)

## Description

Include dependencies, place anywhere in the shiny UI.

## Usage

<pre><code class='language-R'>useConductor()

use_conductor()
</code></pre>

## Examples

``` r
library("conductor")

library(shiny)
library(conductor)

ui <- fluidPage(
 useConductor()
 # also works:
 # use_conductor()
)

server <- function(input, output){}

if(interactive()) shinyApp(ui, server)
```
