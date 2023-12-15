
# use_conductor

Dependencies

## Description

Include dependencies, place anywhere in the shiny UI.

## Usage

<pre><code class='language-R'>useConductor()

use_conductor()
</code></pre>

## Examples

``` r
library(conductor)

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
