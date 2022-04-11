#' Dependencies
#'
#' Include dependencies, place anywhere in the shiny UI.
#'
#' @importFrom shiny singleton tags
#' @importFrom htmltools htmlDependency
#' @export
useConductor <- function(){
  htmlDependency(
    "conductor",
    version = utils::packageVersion("conductor"),
    package = "conductor",
    src = "packer",
    script = "conductor.js"
  )
}


#' Create a "conductor" tour
#'
#' In addition to this page, you can also directly access the documentation
#' of shepherd.js here: <https://shepherdjs.dev/docs/index.html>.
#'
#' @export
Conductor <- R6::R6Class(
  "Conductor",
  private = list(
    steps = list(),
    globals = list(),
    mathjax = FALSE
  ),


  #' @details
  #' Create a new `Conductor` object.
  #'
  #'
  #' @return A `Conductor` object.
  public = list(

    #' @param exitOnEsc Allow closing the tour by pressing "Escape". Default is
    #' `TRUE`.
    #' @param keyboardNavigation Allow navigating the tour with keyboard arrows.
    #' Default is `TRUE`.
    #' @param useModalOverlay Highlight the tour popover and the element (if
    #' specified). Default is `TRUE`.
    #' @param classPrefix Add a prefix to the classes of the tour. This allows
    #' having different CSS for each tour.
    #' @param tourName An (optional) id to give to the tour.
    #' @param stepsContainer
    #' @param modalContainer
    #' @param confirmCancel Ask confirmation to cancel the tour. Default is `FALSE`.
    #' @param confirmCancelMessage Message in the popup that ask confirmation to
    #' close the tour (only works if `confirmCancel = TRUE`).
    #' @param defaultStepOptions A nested list of options to apply to the entire
    #' tour. See `Details`.
    #' @param mathjax Enable MathJax? Default is `FALSE`. This requires importing
    #' MathJax, for example with `shiny::withMathJax()`.
    #' @param onComplete A JavaScript code to run when the tour is completed.
    #' @param onCancel A JavaScript code to run when the tour is cancelled
    #' @param onHide A JavaScript code to run when the tour is hidden
    #' @param onShow A JavaScript code to run when the tour is shown.
    #' @param onStart A JavaScript code to run when the tour starts.
    #' @param onActive A JavaScript code to run when the tour is active.
    #' @param onInactive A JavaScript code to run when the tour is inactive.

    initialize = function(exitOnEsc = TRUE, keyboardNavigation = TRUE,
                          useModalOverlay = TRUE, classPrefix = NULL,
                          tourName = NULL, stepsContainer = NULL,
                          modalContainer = NULL, confirmCancel = FALSE,
                          confirmCancelMessage = NULL,
                          defaultStepOptions = NULL, mathjax = FALSE,
                          onComplete = NULL, onCancel = NULL, onHide = NULL,
                          onShow = NULL, onStart = NULL,
                          onActive = NULL, onInactive = NULL) {

      private$globals <- list(
        exitOnEsc = exitOnEsc,
        keyboardNavigation = keyboardNavigation,
        useModalOverlay = useModalOverlay,
        classPrefix = classPrefix,
        tourName = tourName,
        defaultStepOptions = defaultStepOptions,
        stepsContainer = stepsContainer,
        modalContainer = modalContainer,
        confirmCancel = confirmCancel,
        confirmCancelMessage = confirmCancelMessage,
        onComplete = onComplete,
        onCancel = onCancel,
        onHide = onHide,
        onShow = onShow,
        onStart = onStart,
        onActive = onActive,
        onInactive = onInactive
      )

      private$mathjax <- mathjax
      invisible(self)
    },


    #' @param session A valid Shiny session. If `NULL` (default), the function
    #' attempts to get the session with `shiny::getDefaultReactiveDomain()`.
    #'
    #' @details
    #' Initialise `Conductor`.
    init = function(session = NULL) {
      if(is.null(session)) {
        session <- shiny::getDefaultReactiveDomain()
      }
      session$sendCustomMessage(
        "conductor-init",
        list(
          id = private$id,
          steps = private$steps,
          globals = private$globals,
          mathjax = private$mathjax
        )
      )
      invisible(self)
    },


    #' @param session A valid Shiny session. If `NULL` (default), the function
    #' attempts to get the session with `shiny::getDefaultReactiveDomain()`.
    #'
    #' @details
    #' Start `Conductor`.
    start = function(session = NULL) {
      if(is.null(session)) {
        session <- shiny::getDefaultReactiveDomain()
      }
      session$sendCustomMessage("conductor-start", list(id = private$id))
      invisible(self)
    },


    #' Add a step in a `Conductor` tour
    #'
    #' @param el The element to highlight. It can be an id (for example `#mynav`),
    #' a class (for instance `.navbar`), or a general tag (for example `button`).
    #' If `NULL` (default) or if the selector is not found, the popover will appear
    #' in the center of the page.
    #' @param title Title of the popover.
    #' @param text Text of the popover.
    #' @param position Position of the popover relative to the element. Possible
    #' values are: 'auto', 'auto-start', 'auto-end', 'top', 'top-start', 'top-end',
    #' 'bottom', 'bottom-start', 'bottom-end', 'right', 'right-start', 'right-end',
    #' 'left', 'left-start', 'left-end'.
    #' @param arrow Add an arrow pointing towards the highlighted element? Default
    #' is `TRUE`.
    #' @param canClickTarget Allow the highlighted element to be clicked? Default is
    #' `TRUE`.
    #' @param advanceOn
    #' @param scrollTo
    #' @param cancelIcon A list of two elements: `enabled` is a boolean indicating
    #' whether a "close" icon should be displayed (default is `TRUE`); `label` is
    #' the label to add for `aria-label`.
    #' @param when
    #' @param showOn Either a boolean or a JavaScript expression that returns `true`
    #' or `false`. It indicates whether the step should be displayed in the tour.
    #'
    #' @details

    step = function(el = NULL, title = NULL, text = NULL, position = NULL,
                    arrow = TRUE, is_id = TRUE, canClickTarget = TRUE,
                    advanceOn = NULL, scrollTo = TRUE, cancelIcon = NULL,
                    when = NULL, showOn = NULL) {

      if (is.null(el)) {
        if(!is.null(position)) {
          message("Argument `position` is not used. It requires argument `el`.")
        }
        arrow <- FALSE
      }

      if (!is.null(advanceOn)) {
        if (!is.list(advanceOn) | (is.list(advanceOn) &
                                    length(advanceOn) != 2)) {
          warning("Argument `advanceOn` must be a list of a two elements.",
                  call. = TRUE)
        }
      }

      if (!is.null(cancelIcon)) {
        if (!is.list(cancelIcon)) {
          warning("Argument `cancelIcon` must be a list.",
                  call. = TRUE)
        }
      }

      popover <- list()

      if(!is.null(el)) {
        if (is.null(position)) {
          position <- "auto"
        }
        popover$attachTo <- list(
          element = el,
          on = position
        )
      }
      if(!is.null(title)) popover$title <- as.character(title)
      if(!is.null(text)) popover$text <- as.character(text)
      popover$canClickTarget <- canClickTarget
      popover$arrow <- arrow
      popover$scrollTo <- scrollTo
      popover$showOn <- showOn
      if (!is.null(cancelIcon)) {
        popover$cancelIcon <- list(
          enabled = cancelIcon[[1]],
          label = cancelIcon[[2]]
        )
      }
      if (!is.null(advanceOn)) {
        popover$advanceOn <- list(
          selector = advanceOn[[1]],
          event = advanceOn[[2]]
        )
      }

      # if(private$mathjax) {
      #   popover$when <- paste0("function(element){setTimeout(function(){
      #     MathJax.Hub.Queue(['Typeset', MathJax.Hub]);
      #   }, 300);", when, "}")
      # } else {
      #   if(!is.null(when)) popover$when <- when
      # }

      private$steps <- append(private$steps, list(popover))
      invisible(self)
    },

    is_active = function(session = NULL) {
      if(is.null(session)) {
        session <- shiny::getDefaultReactiveDomain()
      }
      session$sendCustomMessage("conductor-isActive", list(id = private$id))
      invisible(self)
    }

  )
)
