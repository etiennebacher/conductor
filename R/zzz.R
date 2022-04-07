.onLoad <- function(libname, pkgname){
  path <- system.file("packer", package = "conductor")
  shiny::addResourcePath('conductor-assets', path)
}
