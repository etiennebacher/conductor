#' Dependencies
#'
#' Include dependencies, place anywhere in the shiny UI.
#'
#' @importFrom shiny singleton tags
#' @importFrom htmltools htmlDependency
#' @export
useDocent <- function(){
  htmlDependency(
    "docent",
    version = utils::packageVersion("docent"),
    package = "docent",
    src = "packer",
    script = "docent.js"
  )
}

#' @export
Docent <- R6::R6Class(
  "Docent",
  private = list(
    id = paste0(sample(letters, 26), collapse = ""),
    steps = list(),
    globals = list(),
    mathjax = FALSE
  ),
  public = list(

    initialize = function(exitOnEsc = TRUE, keyboardNavigation = TRUE,
                          useModalOverlay = TRUE, classPrefix = NULL,
                          tourName = NULL, stepsContainer = NULL,
                          modalContainer = NULL, confirmCancel = FALSE,
                          confirmCancelMessage = NULL,
                          defaultStepOptions = NULL, mathjax = FALSE) {

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
        confirmCancelMessage = confirmCancelMessage
      )

      private$mathjax <- mathjax
      invisible(self)
    },

    init = function(session = NULL) {
      if(is.null(session)) {
        session <- shiny::getDefaultReactiveDomain()
      }
      session$sendCustomMessage(
        "docent-init",
        list(
          id = private$id,
          steps = private$steps,
          globals = private$globals
        )
      )
      invisible(self)
    },

    start = function(session = NULL) {
      if(is.null(session)) {
        session <- shiny::getDefaultReactiveDomain()
      }
      session$sendCustomMessage("docent-start", list(id = private$id))
      invisible(self)
    },

    step = function(el = NULL, title = NULL, text = NULL, position = NULL,
                    arrow = TRUE, is_id = TRUE, canClickTarget = TRUE,
                    advanceOn = NULL, scrollTo = TRUE, cancelIcon = NULL,
                    when = NULL) {

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
        if (isTRUE(is_id)) {
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
      session$sendCustomMessage("docent-isActive", list(id = private$id))
      invisible(self)
    },

    print = function() {
      print(private$steps)
    }

  )
)
