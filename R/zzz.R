.onLoad <- function(libname, pkgname){
  path <- system.file("packer", package = "docent")
  shiny::addResourcePath('docent-assets', path)
}
