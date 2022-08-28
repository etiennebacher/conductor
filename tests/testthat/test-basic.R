skip_on_cran()

library(shinytest2)

test_that("foo", {
  app <- AppDriver$new(app = testthat::test_path("test-apps/basic"))
  # step 1
  app$expect_html(selector = "div.shepherd-has-title.shepherd-element.shepherd-enabled")
  # step 2
  app$click(selector = "button.shepherd-button:nth-child(2)")
  app$expect_html(selector = "div.shepherd-has-title.shepherd-element.shepherd-centered.shepherd-enabled")
  # step 3
  app$click(selector = "div.shepherd-content:nth-child(1) > footer:nth-child(2) > button:nth-child(2)")
  app$expect_html(selector = "div.shepherd-has-title:nth-child(5)")
  # body after tour
  app$click(selector = "div.shepherd-has-title:nth-child(5) > div:nth-child(2) > footer:nth-child(2) > button:nth-child(2)")
  app$expect_html(selector = "body")
})
