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
                          tourName = NULL, defaultStepOptions = NULL,
                          stepsContainer = NULL, modalContainer = NULL,
                          confirmCancel = FALSE, confirmCancelMessage = NULL) {
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
                    arrow = TRUE, is_id = TRUE, can_click_target = TRUE,
                    advance_on = NULL, scroll = TRUE) {

      if (is.null(el)) {
        if(!is.null(position)) {
          message("Argument `position` is not used. It requires argument `el`.")
        }
        arrow <- FALSE
      }

      if (!is.null(advance_on)) {
        if (!is.list(advance_on) | (is.list(advance_on) &
                                    length(advance_on) != 2)) {
          warning("Argument `advance_on` must be a list of a two elements.",
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
      popover$canClickTarget <- can_click_target
      popover$arrow <- arrow
      popover$scrollTo <- scroll
      popover$advanceOn <- list(
        selector = advance_on[[1]],
        event = advance_on[[2]]
      )

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
