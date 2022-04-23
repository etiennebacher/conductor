#' Dependencies
#'
#' Include dependencies, place anywhere in the shiny UI.
#'
#' @rdname use_conductor
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

#' @rdname use_conductor
#' @export
use_conductor <- useConductor


#' Create a "conductor" tour
#'
#' In addition to this page, you can also directly access the documentation
#' of shepherd.js here: <https://shepherdjs.dev/docs/index.html>.
#'
#' @export
Conductor <- R6::R6Class(
  "Conductor",
  private = list(
    id = paste(sample(letters, length(letters)), collapse = ""),
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
    #' @param confirmCancel Ask confirmation to cancel the tour. Default is
    #' `FALSE`.
    #' @param confirmCancelMessage Message in the popup that ask confirmation to
    #' close the tour (works only if `confirmCancel = TRUE`).
    #' @param defaultStepOptions A nested list of options to apply to the entire
    #' tour. See `Details`.
    #' @param mathjax Enable MathJax? Default is `FALSE`. This requires importing
    #' MathJax, for example with `shiny::withMathJax()`.
    #' @param progress Show a step counter in each step? Default is `FALSE`.
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
                          progress = FALSE, onComplete = NULL, onCancel = NULL,
                          onHide = NULL, onShow = NULL, onStart = NULL,
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
        onInactive = onInactive,
        progress = progress
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




    #' @param title Title of the popover.
    #' @param text Text of the popover.
    #' @param el The element to highlight. It can be an id (for example `#mynav`),
    #' a class (for instance `.navbar`), or a general tag (for example `button`).
    #' If `NULL` (default) or if the selector is not found, the popover will appear
    #' in the center of the page.
    #' @param id Name of the step (optional).
    #' @param position Position of the popover relative to the element. Possible
    #' values are: 'auto', 'auto-start', 'auto-end', 'top', 'top-start', 'top-end',
    #' 'bottom', 'bottom-start', 'bottom-end', 'right', 'right-start', 'right-end',
    #' 'left', 'left-start', 'left-end'.
    #' @param arrow Add an arrow pointing towards the highlighted element. Default
    #' is `TRUE`.
    #' @param canClickTarget Allow the highlighted element to be clicked. Default
    #' is `TRUE`.
    #' @param advanceOn
    #' @param scrollTo
    #' @param cancelIcon A list of two elements: `enabled` is a boolean indicating
    #' whether a "close" icon should be displayed (default is `TRUE`); `label` is
    #' the label to add for `aria-label`.
    #' @param when
    #' @param showOn Either a boolean or a JavaScript expression that returns `true`
    #' or `false`. It indicates whether the step should be displayed in the tour.
    #' @param buttons
    #' @param tabId Id of the `tabsetPanel()`.
    #' @param tab Name of the tab that contains the element.
    #'
    #' @details
    #' Add a step in a `Conductor` tour.

    step = function(title = NULL, text = NULL, el = NULL, position = NULL,
                    arrow = TRUE, tabId = NULL, tab = NULL, canClickTarget = TRUE,
                    advanceOn = NULL, scrollTo = TRUE, cancelIcon = NULL,
                    when = NULL, showOn = NULL, id = NULL, buttons = NULL) {

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

      call <- sys.call()

      popover <- list()

      if(!is.null(el)) {
        if ("el" %in% names(call)) {
          el_in_module <- grepl("^ns\\(", deparse(sys.call()[["el"]]))
        } else {
          el_in_module <- grepl("^ns\\(", deparse(sys.call()[[4]]))
        }
        if (el_in_module) {
          el <- paste0("#", el)
        }
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
      popover$tab <- tab
      popover$tabId <- tabId
      popover$id <- id
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


    #' @param step Id of the step (optional). If `NULL` (default), the current
    #' step is used.
    #' @param title Title of the popover.
    #' @param text Text of the popover.
    #' @param el The element to highlight. It can be an id (for example `#mynav`),
    #' a class (for instance `.navbar`), or a general tag (for example `button`).
    #' If `NULL` (default) or if the selector is not found, the popover will appear
    #' in the center of the page.
    #' @param id Name of the step (optional).
    #' @param position Position of the popover relative to the element. Possible
    #' values are: 'auto', 'auto-start', 'auto-end', 'top', 'top-start', 'top-end',
    #' 'bottom', 'bottom-start', 'bottom-end', 'right', 'right-start', 'right-end',
    #' 'left', 'left-start', 'left-end'.
    #' @param arrow Add an arrow pointing towards the highlighted element. Default
    #' is `TRUE`.
    #' @param canClickTarget Allow the highlighted element to be clicked. Default
    #' is `TRUE`.
    #' @param advanceOn
    #' @param scrollTo
    #' @param cancelIcon A list of two elements: `enabled` is a boolean indicating
    #' whether a "close" icon should be displayed (default is `TRUE`); `label` is
    #' the label to add for `aria-label`.
    #' @param when
    #' @param showOn Either a boolean or a JavaScript expression that returns `true`
    #' or `false`. It indicates whether the step should be displayed in the tour.
    #' @param buttons
    #' @param tabId Id of the `tabsetPanel()`.
    #' @param tab Name of the tab that contains the element.
    #'
    #' @details
    #' Add a step in a `Conductor` tour.

    updateStepOptions = function(step = NULL,
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
                                 id = NULL,
                                 buttons = NULL,
                                 session = NULL) {

      if (is.numeric(step)) {
        stop("Method `updateStepOptions()`: numeric values not supported in arg `step`.")
      }

      if(is.null(session)) {
        session <- shiny::getDefaultReactiveDomain()
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

      call <- sys.call()

      popover <- list()

      if(!is.null(el)) {
        if ("el" %in% names(call)) {
          el_in_module <- grepl("^ns\\(", deparse(sys.call()[["el"]]))
        } else {
          el_in_module <- grepl("^ns\\(", deparse(sys.call()[[4]]))
        }
        if (el_in_module) {
          el <- paste0("#", el)
        }
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
      popover$tab <- tab
      popover$tabId <- tabId
      popover$id <- id
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
      #
      session$sendCustomMessage(
        "conductor-updateStepOptions",
        list(
          id = private$id,
          step = step,
          new = popover
        )
      )
      invisible(self)
    },





    #' @param step Either the id of the step to show (defined in `$step()`) or
    #' its number.
    #' @param session A valid Shiny session. If `NULL` (default), the function
    #' attempts to get the session with `shiny::getDefaultReactiveDomain()`.
    #' @details
    #' Show a specific step.
    #' @export

    show = function(step = NULL, session = NULL) {
      if (is.null(step)) {
        stop("Method `show()` needs a specific step.")
      }
      if(is.null(session)) {
        session <- shiny::getDefaultReactiveDomain()
      }
      if (is.numeric(step)) step <- step - 1
      session$sendCustomMessage(
        "conductor-showStep", list(id = private$id, step = step)
      )
      invisible(self)
    },


    #' @param step A character vector with the id(s) of the step(s) to remove
    #' (defined in `$step()`).
    #' @param session A valid Shiny session. If `NULL` (default), the function
    #' attempts to get the session with `shiny::getDefaultReactiveDomain()`.
    #'
    #' @details
    #' Remove specific step(s).
    #' @export

    remove = function(step = NULL, session = NULL) {
      if (is.null(step)) {
        stop("Method `remove()` needs a specific step.")
      } else if (is.numeric(step)) {
        stop("Method `remove()`: numeric values not supported in arg `step`.")
      }
      if(is.null(session)) {
        session <- shiny::getDefaultReactiveDomain()
      }
      session$sendCustomMessage(
        "conductor-removeStep", list(id = private$id, step = step)
      )
      invisible(self)
    },


    #' @param session A valid Shiny session. If `NULL` (default), the function
    #' attempts to get the session with `shiny::getDefaultReactiveDomain()`.
    #' @details
    #' Advances the tour to the next step.
    #' @export

    moveNext = function(session = NULL) {
      if(is.null(session)) {
        session <- shiny::getDefaultReactiveDomain()
      }
      session$sendCustomMessage(
        "conductor-next", list(id = private$id)
      )
      invisible(self)
    },



    #' @param session A valid Shiny session. If `NULL` (default), the function
    #' attempts to get the session with `shiny::getDefaultReactiveDomain()`.
    #' @details
    #' Shows the previous step.
    #' @export

    moveBack = function(session = NULL) {
      if(is.null(session)) {
        session <- shiny::getDefaultReactiveDomain()
      }
      session$sendCustomMessage(
        "conductor-back", list(id = private$id)
      )
      invisible(self)
    },



    #' @param session A valid Shiny session. If `NULL` (default), the function
    #' attempts to get the session with `shiny::getDefaultReactiveDomain()`.
    #' @details
    #' Cancels the tour.
    #' @export

    cancel = function(session = NULL) {
      if(is.null(session)) {
        session <- shiny::getDefaultReactiveDomain()
      }
      session$sendCustomMessage(
        "conductor-cancel", list(id = private$id)
      )
      invisible(self)
    },



    #' @param session A valid Shiny session. If `NULL` (default), the function
    #' attempts to get the session with `shiny::getDefaultReactiveDomain()`.
    #' @details
    #' Hides the current step.
    #' @export

    hide = function(session = NULL) {
      if(is.null(session)) {
        session <- shiny::getDefaultReactiveDomain()
      }
      session$sendCustomMessage(
        "conductor-hide", list(id = private$id)
      )
      invisible(self)
    },



    #' @param session A valid Shiny session. If `NULL` (default), the function
    #' attempts to get the session with `shiny::getDefaultReactiveDomain()`.
    #' @details
    #' Get the id of the current step. If no `id` was specified in `$step()`,
    #' a random id is generated.
    #' @export
    getCurrentStep = function(session = NULL) {
      if(is.null(session)) {
        session <- shiny::getDefaultReactiveDomain()
      }
      session$sendCustomMessage(
        "conductor-getCurrentStep", list(id = private$id)
      )
      session$input[[paste0(private$id, "_current_step")]]
    },


    #' @param step Id of the step (optional). If `NULL` (default), the current
    #' step is used.
    #' @param session A valid Shiny session. If `NULL` (default), the function
    #' attempts to get the session with `shiny::getDefaultReactiveDomain()`.
    #' @details
    #' Get a list of two elements about the highlighted element of a specific
    #' step: its `id` and its `class`.
    #' @export
    getHighlightedElement = function(step = NULL, session = NULL) {
      if(is.null(session)) {
        session <- shiny::getDefaultReactiveDomain()
      }
      if (is.numeric(step)) {
        stop("Method `getHighlightedElement()`: numeric values not supported in arg `step`.")
      }
      session$sendCustomMessage(
        "conductor-getHighlightedElement", list(id = private$id, step = step)
      )
      list(
        id = session$input[[paste0(private$id, "_target_id")]],
        class = session$input[[paste0(private$id, "_target_class")]]
      )
    },

    #' @param step Id of the step (optional). If `NULL` (default), the current
    #' step is used.
    #' @param session A valid Shiny session. If `NULL` (default), the function
    #' attempts to get the session with `shiny::getDefaultReactiveDomain()`.
    #' @details
    #' Returns a value `TRUE` or `FALSE` indicating whether the step is centered.
    #' @export
    isCentered = function(step = NULL, session = NULL) {
      if(is.null(session)) {
        session <- shiny::getDefaultReactiveDomain()
      }
      if (is.numeric(step)) {
        stop("Method `isCentered()`: numeric values not supported in arg `step`.")
      }
      session$sendCustomMessage(
        "conductor-isCentered", list(id = private$id, step = step)
      )
      session$input[[paste0(private$id, "_step_is_centered")]]
    },



    #' @param step Id of the step (optional). If `NULL` (default), the current
    #' step is used.
    #' @param session A valid Shiny session. If `NULL` (default), the function
    #' attempts to get the session with `shiny::getDefaultReactiveDomain()`.
    #' @details
    #' Returns a value `TRUE` or `FALSE` indicating whether the step is open.
    #' @export
    isOpen = function(step = NULL, session = NULL) {
      if(is.null(session)) {
        session <- shiny::getDefaultReactiveDomain()
      }
      if (is.numeric(step)) {
        stop("Method `isOpen()`: numeric values not supported in arg `step`.")
      }
      session$sendCustomMessage(
        "conductor-isOpen", list(id = private$id, step = step)
      )
      session$input[[paste0(private$id, "_step_is_open")]]
    },


    isActive = function(session = NULL) {
      if(is.null(session)) {
        session <- shiny::getDefaultReactiveDomain()
      }
      session$sendCustomMessage("conductor-isActive", list(id = private$id))
      session$input[[paste0(private$id, "_is_active")]]
    }
  )
)
