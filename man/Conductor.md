
# Create a "conductor" tour

[**Source code**](https://github.com/etiennebacher/conductor/tree/main/R/#L)

## Description

In addition to this page, you can also directly access the documentation
of shepherd.js here:
<a href="https://shepherdjs.dev/docs/index.html">https://shepherdjs.dev/docs/index.html</a>.

## Methods

<h4>
Public methods
</h4>
<ul>
<li>

<a href="#method-Conductor-new"><code>Conductor$new()</code></a>

</li>
<li>

<a href="#method-Conductor-init"><code>Conductor$init()</code></a>

</li>
<li>

<a href="#method-Conductor-start"><code>Conductor$start()</code></a>

</li>
<li>

<a href="#method-Conductor-step"><code>Conductor$step()</code></a>

</li>
<li>

<a href="#method-Conductor-updateStepOptions"><code>Conductor$updateStepOptions()</code></a>

</li>
<li>

<a href="#method-Conductor-show"><code>Conductor$show()</code></a>

</li>
<li>

<a href="#method-Conductor-remove"><code>Conductor$remove()</code></a>

</li>
<li>

<a href="#method-Conductor-moveNext"><code>Conductor$moveNext()</code></a>

</li>
<li>

<a href="#method-Conductor-moveBack"><code>Conductor$moveBack()</code></a>

</li>
<li>

<a href="#method-Conductor-cancel"><code>Conductor$cancel()</code></a>

</li>
<li>

<a href="#method-Conductor-complete"><code>Conductor$complete()</code></a>

</li>
<li>

<a href="#method-Conductor-hide"><code>Conductor$hide()</code></a>

</li>
<li>

<a href="#method-Conductor-getCurrentStep"><code>Conductor$getCurrentStep()</code></a>

</li>
<li>

<a href="#method-Conductor-getHighlightedElement"><code>Conductor$getHighlightedElement()</code></a>

</li>
<li>

<a href="#method-Conductor-isOpen"><code>Conductor$isOpen()</code></a>

</li>
<li>

<a href="#method-Conductor-isActive"><code>Conductor$isActive()</code></a>

</li>
<li>

<a href="#method-Conductor-clone"><code>Conductor$clone()</code></a>

</li>
</ul>
<hr>

<a id="method-Conductor-new"></a>

<h4>
Method <code>new()</code>
</h4>
<h5>
Usage
</h5>

<pre>Conductor\$new(
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
  progress = FALSE,
  onComplete = NULL,
  onCancel = NULL,
  onHide = NULL,
  onShow = NULL,
  onStart = NULL,
  onActive = NULL,
  onInactive = NULL
)</pre>

<h5>
Arguments
</h5>

<dl>
<dt>
<code>exitOnEsc</code>
</dt>
<dd>
Allow closing the tour by pressing "Escape". Default is
<code>TRUE</code>.
</dd>
<dt>
<code>keyboardNavigation</code>
</dt>
<dd>
Allow navigating the tour with keyboard arrows. Default is
<code>TRUE</code>.
</dd>
<dt>
<code>useModalOverlay</code>
</dt>
<dd>
Highlight the tour popover and the element (if specified). Default is
<code>TRUE</code>.
</dd>
<dt>
<code>classPrefix</code>
</dt>
<dd>
Add a prefix to the classes of the tour. This allows having different
CSS for each tour.
</dd>
<dt>
<code>tourName</code>
</dt>
<dd>
An (optional) name to give to the tour.
</dd>
<dt>
<code>stepsContainer</code>
</dt>
<dd>
An optional container element for the steps. If <code>NULL</code>
(default), the steps will be appended to <code>document.body</code>.
</dd>
<dt>
<code>modalContainer</code>
</dt>
<dd>
An optional container element for the modal. If <code>NULL</code>
(default), the modal will be appended to <code>document.body</code>.
</dd>
<dt>
<code>confirmCancel</code>
</dt>
<dd>
Ask confirmation to cancel the tour. Default is <code>FALSE</code>.
</dd>
<dt>
<code>confirmCancelMessage</code>
</dt>
<dd>
Message in the popup that ask confirmation to close the tour (works only
if <code>confirmCancel = TRUE</code>).
</dd>
<dt>
<code>defaultStepOptions</code>
</dt>
<dd>
A nested list of options to apply to the entire tour. See
<code>Details</code>.
</dd>
<dt>
<code>mathjax</code>
</dt>
<dd>
Enable MathJax? Default is <code>FALSE</code>. This requires importing
MathJax, for example with <code>shiny::withMathJax()</code>.
</dd>
<dt>
<code>progress</code>
</dt>
<dd>
Show a step counter in each step? Default is <code>FALSE</code>.
</dd>
<dt>
<code>onComplete</code>
</dt>
<dd>
A JavaScript code to run when the tour is completed.
</dd>
<dt>
<code>onCancel</code>
</dt>
<dd>
A JavaScript code to run when the tour is cancelled.
</dd>
<dt>
<code>onHide</code>
</dt>
<dd>
A JavaScript code to run when the tour is hidden.
</dd>
<dt>
<code>onShow</code>
</dt>
<dd>
A JavaScript code to run when the tour is shown.
</dd>
<dt>
<code>onStart</code>
</dt>
<dd>
A JavaScript code to run when the tour starts.
</dd>
<dt>
<code>onActive</code>
</dt>
<dd>
A JavaScript code to run when the tour is active.
</dd>
<dt>
<code>onInactive</code>
</dt>
<dd>
A JavaScript code to run when the tour is inactive.
</dd>
</dl>

<h5>
Details
</h5>

Create a new <code>Conductor</code> object.

<h5>
Returns
</h5>

A <code>Conductor</code> object.

<hr>

<a id="method-Conductor-init"></a>

<h4>
Method <code>init()</code>
</h4>
<h5>
Usage
</h5>

<pre>Conductor\$init(session = NULL)</pre>

<h5>
Arguments
</h5>

<dl>
<dt>
<code>session</code>
</dt>
<dd>
A valid Shiny session. If <code>NULL</code> (default), the function
attempts to get the session with
<code>shiny::getDefaultReactiveDomain()</code>.
</dd>
</dl>

<h5>
Details
</h5>

Initialise <code>Conductor</code>.

<hr>

<a id="method-Conductor-start"></a>

<h4>
Method <code>start()</code>
</h4>
<h5>
Usage
</h5>

<pre>Conductor\$start(session = NULL)</pre>

<h5>
Arguments
</h5>

<dl>
<dt>
<code>session</code>
</dt>
<dd>
A valid Shiny session. If <code>NULL</code> (default), the function
attempts to get the session with
<code>shiny::getDefaultReactiveDomain()</code>.
</dd>
</dl>

<h5>
Details
</h5>

Start <code>Conductor</code>.

<hr>

<a id="method-Conductor-step"></a>

<h4>
Method <code>step()</code>
</h4>
<h5>
Usage
</h5>

<pre>Conductor\$step(
  title = NULL,
  text = NULL,
  el = NULL,
  position = NULL,
  arrow = TRUE,
  tabId = NULL,
  tab = NULL,
  canClickTarget = TRUE,
  advanceOn = NULL,
  scrollTo = NULL,
  cancelIcon = NULL,
  showOn = NULL,
  id = NULL,
  buttons = NULL,
  classes = NULL,
  highlightClass = NULL,
  onComplete = NULL,
  onCancel = NULL,
  onHide = NULL,
  onShow = NULL
)</pre>

<h5>
Arguments
</h5>

<dl>
<dt>
<code>title</code>
</dt>
<dd>
Title of the popover.
</dd>
<dt>
<code>text</code>
</dt>
<dd>
Text of the popover.
</dd>
<dt>
<code>el</code>
</dt>
<dd>
The element to highlight. It can be an id (for example
<code style="white-space: pre;">#mynav</code>), a class (for instance
<code>.navbar</code>), or a general tag (for example
<code>button</code>). If <code>NULL</code> (default) or if the selector
is not found, the popover will appear in the center of the page.
</dd>
<dt>
<code>position</code>
</dt>
<dd>
Position of the popover relative to the element. Possible values are:
‘auto’, ‘auto-start’, ‘auto-end’, ‘top’, ‘top-start’, ‘top-end’,
‘bottom’, ‘bottom-start’, ‘bottom-end’, ‘right’, ‘right-start’,
‘right-end’, ‘left’, ‘left-start’, ‘left-end’.
</dd>
<dt>
<code>arrow</code>
</dt>
<dd>
Add an arrow pointing towards the highlighted element. Default is
<code>TRUE</code>.
</dd>
<dt>
<code>tabId</code>
</dt>
<dd>
Id of the <code>tabsetPanel()</code>.
</dd>
<dt>
<code>tab</code>
</dt>
<dd>
Name of the tab that contains the element.
</dd>
<dt>
<code>canClickTarget</code>
</dt>
<dd>
Allow the highlighted element to be clicked. Default is
<code>TRUE</code>.
</dd>
<dt>
<code>advanceOn</code>
</dt>
<dd>
An action on the page which should advance the tour to the next step. It
should be a list with a string selector and an event name.
</dd>
<dt>
<code>scrollTo</code>
</dt>
<dd>
Should the element be scrolled to when this step is shown? Default is
<code>TRUE</code>.
</dd>
<dt>
<code>cancelIcon</code>
</dt>
<dd>
A list of two elements: <code>enabled</code> is a boolean indicating
whether a "close" icon should be displayed (default is
<code>TRUE</code>); <code>label</code> is the label to add for
<code>aria-label</code>.
</dd>
<dt>
<code>showOn</code>
</dt>
<dd>
Either a boolean or a JavaScript expression that returns
<code>true</code> or <code>false</code>. It indicates whether the step
should be displayed in the tour.
</dd>
<dt>
<code>id</code>
</dt>
<dd>
Name of the step (optional).
</dd>
<dt>
<code>buttons</code>
</dt>
<dd>
A list of lists. Each "sublist" contains the information for one button.
There are six possible arguments for each button: action ("back" or
"next"), text (name of the button), secondary
(<code>TRUE</code>/<code>FALSE</code>), disabled
(<code>TRUE</code>/<code>FALSE</code>), label (aria-label of the
button), and classes (for finer CSS customization).
</dd>
<dt>
<code>classes</code>
</dt>
<dd>
A character vector of extra classes to add to the step’s content
element.
</dd>
<dt>
<code>highlightClass</code>
</dt>
<dd>
An extra class to apply to <code>el</code> when it is highlighted. Only
one extra class is accepted.
</dd>
<dt>
<code>onComplete</code>
</dt>
<dd>
Some JavaScript code to run when the step is complete (only for the last
step).
</dd>
<dt>
<code>onCancel</code>
</dt>
<dd>
Some JavaScript code to run when the step is cancelled.
</dd>
<dt>
<code>onHide</code>
</dt>
<dd>
Some JavaScript code to run when the step is hidden.
</dd>
<dt>
<code>onShow</code>
</dt>
<dd>
Some JavaScript code to run when the step is shown.
</dd>
</dl>

<h5>
Details
</h5>

Add a step in a <code>Conductor</code> tour.

<hr>

<a id="method-Conductor-updateStepOptions"></a>

<h4>
Method <code>updateStepOptions()</code>
</h4>
<h5>
Usage
</h5>

<pre>Conductor\$updateStepOptions(
  step = NULL,
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
  showOn = NULL,
  id = NULL,
  buttons = NULL,
  classes = NULL,
  highlightClass = NULL,
  session = NULL
)</pre>

<h5>
Arguments
</h5>

<dl>
<dt>
<code>step</code>
</dt>
<dd>
Id of the step (optional). If <code>NULL</code> (default), the current
step is used.
</dd>
<dt>
<code>title</code>
</dt>
<dd>
Title of the popover.
</dd>
<dt>
<code>text</code>
</dt>
<dd>
Text of the popover.
</dd>
<dt>
<code>el</code>
</dt>
<dd>
The element to highlight. It can be an id (for example
<code style="white-space: pre;">#mynav</code>), a class (for instance
<code>.navbar</code>), or a general tag (for example
<code>button</code>). If <code>NULL</code> (default) or if the selector
is not found, the popover will appear in the center of the page.
</dd>
<dt>
<code>position</code>
</dt>
<dd>
Position of the popover relative to the element. Possible values are:
‘auto’, ‘auto-start’, ‘auto-end’, ‘top’, ‘top-start’, ‘top-end’,
‘bottom’, ‘bottom-start’, ‘bottom-end’, ‘right’, ‘right-start’,
‘right-end’, ‘left’, ‘left-start’, ‘left-end’.
</dd>
<dt>
<code>arrow</code>
</dt>
<dd>
Add an arrow pointing towards the highlighted element. Default is
<code>TRUE</code>.
</dd>
<dt>
<code>tabId</code>
</dt>
<dd>
Id of the <code>tabsetPanel()</code>.
</dd>
<dt>
<code>tab</code>
</dt>
<dd>
Name of the tab that contains the element.
</dd>
<dt>
<code>canClickTarget</code>
</dt>
<dd>
Allow the highlighted element to be clicked. Default is
<code>TRUE</code>.
</dd>
<dt>
<code>advanceOn</code>
</dt>
<dd>
An action on the page which should advance shepherd to the next step. It
should be a list with a string selector and an event name.
</dd>
<dt>
<code>scrollTo</code>
</dt>
<dd>
Should the element be scrolled to when this step is shown? Default is
<code>TRUE</code>.
</dd>
<dt>
<code>cancelIcon</code>
</dt>
<dd>
A list of two elements: <code>enabled</code> is a boolean indicating
whether a "close" icon should be displayed (default is
<code>TRUE</code>); <code>label</code> is the label to add for
<code>aria-label</code>.
</dd>
<dt>
<code>showOn</code>
</dt>
<dd>
Either a boolean or a JavaScript expression that returns
<code>true</code> or <code>false</code>. It indicates whether the step
should be displayed in the tour.
</dd>
<dt>
<code>id</code>
</dt>
<dd>
Name of the step (optional).
</dd>
<dt>
<code>buttons</code>
</dt>
<dd>
A list of lists. Each "sublist" contains the information for one button.
There are six possible arguments for each button: action ("back" or
"next"), text (name of the button), secondary
(<code>TRUE</code>/<code>FALSE</code>), disabled
(<code>TRUE</code>/<code>FALSE</code>), label (aria-label of the
button), and classes (for finer CSS customization).
</dd>
<dt>
<code>classes</code>
</dt>
<dd>
A character vector of extra classes to add to the step’s content
element.
</dd>
<dt>
<code>highlightClass</code>
</dt>
<dd>
An extra class to apply to <code>el</code> when it is highlighted. Only
one extra class is accepted.
</dd>
<dt>
<code>session</code>
</dt>
<dd>
A valid Shiny session. If <code>NULL</code> (default), the function
attempts to get the session with
<code>shiny::getDefaultReactiveDomain()</code>.
</dd>
<dt>
<code>onShow</code>
</dt>
<dd>
Some JavaScript code to run when the step is shown.
</dd>
<dt>
<code>onHide</code>
</dt>
<dd>
Some JavaScript code to run when the step is hidden.
</dd>
<dt>
<code>onCancel</code>
</dt>
<dd>
Some JavaScript code to run when the step is cancelled.
</dd>
<dt>
<code>onComplete</code>
</dt>
<dd>
Some JavaScript code to run when the step is complete (only for the last
step).
</dd>
</dl>

<h5>
Details
</h5>

Modify the options of a specific step.

<hr>

<a id="method-Conductor-show"></a>

<h4>
Method <code>show()</code>
</h4>
<h5>
Usage
</h5>

<pre>Conductor\$show(step = NULL, session = NULL)</pre>

<h5>
Arguments
</h5>

<dl>
<dt>
<code>step</code>
</dt>
<dd>
Either the id of the step to show (defined in
<code style="white-space: pre;">$step()</code>) or its number.
</dd>
<dt>
<code>session</code>
</dt>
<dd>
A valid Shiny session. If <code>NULL</code> (default), the function
attempts to get the session with
<code>shiny::getDefaultReactiveDomain()</code>.
</dd>
</dl>

<h5>
Details
</h5>

Show a specific step.

<hr>

<a id="method-Conductor-remove"></a>

<h4>
Method <code>remove()</code>
</h4>
<h5>
Usage
</h5>

<pre>Conductor\$remove(step = NULL, session = NULL)</pre>

<h5>
Arguments
</h5>

<dl>
<dt>
<code>step</code>
</dt>
<dd>
A character vector with the id(s) of the step(s) to remove (defined in
<code style="white-space: pre;">$step()</code>).
</dd>
<dt>
<code>session</code>
</dt>
<dd>
A valid Shiny session. If <code>NULL</code> (default), the function
attempts to get the session with
<code>shiny::getDefaultReactiveDomain()</code>.
</dd>
</dl>

<h5>
Details
</h5>

Remove specific step(s).

<hr>

<a id="method-Conductor-moveNext"></a>

<h4>
Method <code>moveNext()</code>
</h4>
<h5>
Usage
</h5>

<pre>Conductor\$moveNext(session = NULL)</pre>

<h5>
Arguments
</h5>

<dl>
<dt>
<code>session</code>
</dt>
<dd>
A valid Shiny session. If <code>NULL</code> (default), the function
attempts to get the session with
<code>shiny::getDefaultReactiveDomain()</code>.
</dd>
</dl>

<h5>
Details
</h5>

Advances the tour to the next step.

<hr>

<a id="method-Conductor-moveBack"></a>

<h4>
Method <code>moveBack()</code>
</h4>
<h5>
Usage
</h5>

<pre>Conductor\$moveBack(session = NULL)</pre>

<h5>
Arguments
</h5>

<dl>
<dt>
<code>session</code>
</dt>
<dd>
A valid Shiny session. If <code>NULL</code> (default), the function
attempts to get the session with
<code>shiny::getDefaultReactiveDomain()</code>.
</dd>
</dl>

<h5>
Details
</h5>

Shows the previous step.

<hr>

<a id="method-Conductor-cancel"></a>

<h4>
Method <code>cancel()</code>
</h4>
<h5>
Usage
</h5>

<pre>Conductor\$cancel(session = NULL)</pre>

<h5>
Arguments
</h5>

<dl>
<dt>
<code>session</code>
</dt>
<dd>
A valid Shiny session. If <code>NULL</code> (default), the function
attempts to get the session with
<code>shiny::getDefaultReactiveDomain()</code>.
</dd>
</dl>

<h5>
Details
</h5>

Cancels the tour.

<hr>

<a id="method-Conductor-complete"></a>

<h4>
Method <code>complete()</code>
</h4>
<h5>
Usage
</h5>

<pre>Conductor\$complete(session = NULL)</pre>

<h5>
Arguments
</h5>

<dl>
<dt>
<code>session</code>
</dt>
<dd>
A valid Shiny session. If <code>NULL</code> (default), the function
attempts to get the session with
<code>shiny::getDefaultReactiveDomain()</code>.
</dd>
</dl>

<h5>
Details
</h5>

Completes the tour.

<hr>

<a id="method-Conductor-hide"></a>

<h4>
Method <code>hide()</code>
</h4>
<h5>
Usage
</h5>

<pre>Conductor\$hide(session = NULL)</pre>

<h5>
Arguments
</h5>

<dl>
<dt>
<code>session</code>
</dt>
<dd>
A valid Shiny session. If <code>NULL</code> (default), the function
attempts to get the session with
<code>shiny::getDefaultReactiveDomain()</code>.
</dd>
</dl>

<h5>
Details
</h5>

Hides the current step.

<hr>

<a id="method-Conductor-getCurrentStep"></a>

<h4>
Method <code>getCurrentStep()</code>
</h4>
<h5>
Usage
</h5>

<pre>Conductor\$getCurrentStep(session = NULL)</pre>

<h5>
Arguments
</h5>

<dl>
<dt>
<code>session</code>
</dt>
<dd>
A valid Shiny session. If <code>NULL</code> (default), the function
attempts to get the session with
<code>shiny::getDefaultReactiveDomain()</code>.
</dd>
</dl>

<h5>
Details
</h5>

Get the id of the current step. If no <code>id</code> was specified in
<code style="white-space: pre;">$step()</code>, a random id is
generated.

<hr>

<a id="method-Conductor-getHighlightedElement"></a>

<h4>
Method <code>getHighlightedElement()</code>
</h4>
<h5>
Usage
</h5>

<pre>Conductor\$getHighlightedElement(session = NULL)</pre>

<h5>
Arguments
</h5>

<dl>
<dt>
<code>session</code>
</dt>
<dd>
A valid Shiny session. If <code>NULL</code> (default), the function
attempts to get the session with
<code>shiny::getDefaultReactiveDomain()</code>.
</dd>
</dl>

<h5>
Details
</h5>

Returns the id of the highlighted element of the current step. If this
element has no id, it returns its class.

<hr>

<a id="method-Conductor-isOpen"></a>

<h4>
Method <code>isOpen()</code>
</h4>
<h5>
Usage
</h5>

<pre>Conductor\$isOpen(step = NULL, session = NULL)</pre>

<h5>
Arguments
</h5>

<dl>
<dt>
<code>step</code>
</dt>
<dd>
Id of the step (optional). If <code>NULL</code> (default), the current
step is used.
</dd>
<dt>
<code>session</code>
</dt>
<dd>
A valid Shiny session. If <code>NULL</code> (default), the function
attempts to get the session with
<code>shiny::getDefaultReactiveDomain()</code>.
</dd>
</dl>

<h5>
Details
</h5>

Returns a value <code>TRUE</code> or <code>FALSE</code> indicating
whether the step is open.

<hr>

<a id="method-Conductor-isActive"></a>

<h4>
Method <code>isActive()</code>
</h4>
<h5>
Usage
</h5>

<pre>Conductor\$isActive(session = NULL)</pre>

<h5>
Arguments
</h5>

<dl>
<dt>
<code>session</code>
</dt>
<dd>
A valid Shiny session. If <code>NULL</code> (default), the function
attempts to get the session with
<code>shiny::getDefaultReactiveDomain()</code>.
</dd>
</dl>

<h5>
Details
</h5>

Returns a value <code>TRUE</code> or <code>FALSE</code> indicating
whether the tour is active.

<hr>

<a id="method-Conductor-clone"></a>

<h4>
Method <code>clone()</code>
</h4>

The objects of this class are cloneable with this method.

<h5>
Usage
</h5>

<pre>Conductor\$clone(deep = FALSE)</pre>

<h5>
Arguments
</h5>

<dl>
<dt>
<code>deep</code>
</dt>
<dd>
Whether to make a deep clone.
</dd>
</dl>
