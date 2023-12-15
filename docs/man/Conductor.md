
# Conductor

Create a "conductor" tour

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

<pre>Conductor$new(
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
<div class="arguments">

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
