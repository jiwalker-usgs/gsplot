context("config")

cleanup <- function() {
  loadConfig()
}

test_that("lists and named args are identical", {
  expect_equal(gsplot:::config("par",list("mar"=c(1,2,3,4)))$mar, c(1,2,3,4))
  expect_equal(gsplot:::config("par",mar=c(1,2,3,4))$mar, c(1,2,3,4))
})

test_that("empty sets on gsplot are ignored",{
  expect_is(gsplot:::config("par"), 'list')
})

test_that("persisting to config alters environment", {
  gsplot:::config("par", tcl=0.5, persist=TRUE)
  gsplot:::config("points", col="blue", persist=TRUE)
  expect_equal(gsplot:::config("par")$tcl, 0.5)
  expect_equal(gsplot:::config("points")$col, "blue")
  cleanup()
})

test_that("formals are correctly retrieved", {
  expect_equal(length(config("par")), 7)
  expect_equal(names(config("points")), c("pch", "col"))
  expect_equal(length(config("arrows")), 0)
})

test_that("non-existant type hits error", {
  expect_error(config("foo"))
})
