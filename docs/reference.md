# Reference 

## Conductor

### Description

In addition to this page, you can also directly access the documentation
of shepherd.js here: <https://shepherdjs.dev/docs/index.html>.

### Methods

#### Public methods

-   [`Conductor$new()`](#method-new)

-   [`Conductor$init()`](#method-init)

-   [`Conductor$start()`](#method-start)

-   [`Conductor$step()`](#method-step)

-   [`Conductor$is_active()`](#method-is_active)

-   [`Conductor$clone()`](#method-clone)

------------------------------------------------------------------------

<span id="method-new"></span>

#### Method `new()`

##### Usage

    Conductor$new(
      exitOnEsc = TRUE,
      keyboardNavigation = TRUE,
      useModalOverlay = TRUE,
      classPrefix = NULL,
      tourName = NULL,
      stepsContainer = NULL,
      modalContainer = NULL,
      confirmCancel = FALSE,
      confirmCancelMessage = NULL,
      defaultStepOptions = NULL,
      mathjax = FALSE,
      onComplete = NULL,
      onCancel = NULL,
      onHide = NULL,
      onShow = NULL,
      onStart = NULL,
      onActive = NULL,
      onInactive = NULL
    )

##### Arguments

`exitOnEsc`  
Allow closing the tour by pressing "Escape". Default is `TRUE`.

`keyboardNavigation`  
Allow navigating the tour with keyboard arrows. Default is `TRUE`.

`useModalOverlay`  
Highlight the tour popover and the element (if specified). Default is
`TRUE`.

`classPrefix`  
Add a prefix to the classes of the tour. This allows having different
CSS for each tour.

`tourName`  
An (optional) id to give to the tour.

`confirmCancel`  
Ask confirmation to cancel the tour. Default is `FALSE`.

`confirmCancelMessage`  
Message in the popup that ask confirmation to close the tour (works only
if `confirmCancel = TRUE`).

`defaultStepOptions`  
A nested list of options to apply to the entire tour. See `Details`.

`mathjax`  
Enable MathJax? Default is `FALSE`. This requires importing MathJax, for
example with `shiny::withMathJax()`.

`onComplete`  
A JavaScript code to run when the tour is completed.

`onCancel`  
A JavaScript code to run when the tour is cancelled

`onHide`  
A JavaScript code to run when the tour is hidden

`onShow`  
A JavaScript code to run when the tour is shown.

`onStart`  
A JavaScript code to run when the tour starts.

`onActive`  
A JavaScript code to run when the tour is active.

`onInactive`  
A JavaScript code to run when the tour is inactive.

##### Details

Create a new `Conductor` object.

##### Returns

A `Conductor` object.

------------------------------------------------------------------------

<span id="method-init"></span>

#### Method `init()`

##### Usage

    Conductor$init(session = NULL)

##### Arguments

`session`  
A valid Shiny session. If `NULL` (default), the function attempts to get
the session with `shiny::getDefaultReactiveDomain()`.

##### Details

Initialise `Conductor`.

------------------------------------------------------------------------

<span id="method-start"></span>

#### Method `start()`

##### Usage

    Conductor$start(session = NULL)

##### Arguments

`session`  
A valid Shiny session. If `NULL` (default), the function attempts to get
the session with `shiny::getDefaultReactiveDomain()`.

##### Details

Start `Conductor`.

------------------------------------------------------------------------

<span id="method-step"></span>

#### Method `step()`

##### Usage

    Conductor$step(
      title = NULL,
      text = NULL,
      el = NULL,
      position = NULL,
      arrow = TRUE,
      tabId = NULL,
      tab = NULL,
      canClickTarget = TRUE,
      advanceOn = NULL,
      scrollTo = TRUE,
      cancelIcon = NULL,
      when = NULL,
      showOn = NULL,
      buttons = NULL
    )

##### Arguments

`title`  
Title of the popover.

`text`  
Text of the popover.

`el`  
The element to highlight. It can be an id (for example `#mynav`), a
class (for instance `.navbar`), or a general tag (for example `button`).
If `NULL` (default) or if the selector is not found, the popover will
appear in the center of the page.

`position`  
Position of the popover relative to the element. Possible values are:
'auto', 'auto-start', 'auto-end', 'top', 'top-start', 'top-end',
'bottom', 'bottom-start', 'bottom-end', 'right', 'right-start',
'right-end', 'left', 'left-start', 'left-end'.

`arrow`  
Add an arrow pointing towards the highlighted element. Default is
`TRUE`.

`tabId`  
Id of the `tabsetPanel()`.

`tab`  
Name of the tab that contains the element.

`canClickTarget`  
Allow the highlighted element to be clicked. Default is `TRUE`.

`cancelIcon`  
A list of two elements: `enabled` is a boolean indicating whether a
"close" icon should be displayed (default is `TRUE`); `label` is the
label to add for `aria-label`.

`showOn`  
Either a boolean or a JavaScript expression that returns `true` or
`false`. It indicates whether the step should be displayed in the tour.

##### Details

Add a step in a `Conductor` tour.

------------------------------------------------------------------------

<span id="method-is_active"></span>

#### Method `is_active()`

##### Usage

    Conductor$is_active(session = NULL)

------------------------------------------------------------------------

<span id="method-clone"></span>

#### Method `clone()`

The objects of this class are cloneable with this method.

##### Usage

    Conductor$clone(deep = FALSE)

##### Arguments

`deep`  
Whether to make a deep clone.


---
## UseConductor

### Description

Include dependencies, place anywhere in the shiny UI.

### Usage

    useConductor()


---
