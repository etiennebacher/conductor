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

    init = function(session = NULL) {
      if(is.null(session)) {
        session <- shiny::getDefaultReactiveDomain()
      }
      session$sendCustomMessage(
        "docent-init",
        list(
          id = private$id,
          steps = private$steps
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
                    arrow = TRUE, is_id = TRUE, can_click_target = TRUE) {

      if (is.null(el)) {
        if(!is.null(position)) {
          message("Argument `position` is not used. It requires argument `el`.")
        }
        arrow <- FALSE
      }

      popover <- list()

      if(!is.null(el)) {
        if (isTRUE(is_id)) {
          el <- paste0("#", el)
        }
        if (is.null(position)) {
          position <- "auto"
        }
        attachTo <- list(
          element = el,
          on = position
        )
        popover$attachTo <- attachTo
      }
      if(!is.null(title)) popover$title <- as.character(title)
      if(!is.null(text)) popover$text <- as.character(text)
      popover$canClickTarget <- can_click_target
      popover$arrow <- arrow

      private$steps <- append(private$steps, list(popover))
      invisible(self)
    },

    print = function() {
      print(private$steps)
    }

  )
)
