context('statistic')

library(modelsummary)

mod <- list()
mod$OLS <- lm(am ~ drat, data = mtcars)
mod$Logit <- glm(am ~ qsec, data = mtcars, family = binomial())

test_that("std.error", {

  raw <- modelsummary:::extract_models(mod, statistic = 'std.error')

  truth <- c('(0.434)', '(0.120)')
  expect_equal(truth, unname(raw[[4]][c(2, 4)]))

  truth <- c('(4.045)', '(0.228)')
  expect_equal(truth, unname(raw[[5]][c(2, 6)]))
})

test_that("p.value", {

  raw <- modelsummary:::extract_models(mod, statistic = 'p.value', fmt = '%.6f')

  truth <- c('(0.000078)', '(0.000005)')
  expect_equal(truth, unname(raw[[4]][c(2, 4)]))

  truth <- c('(0.241402)', '(0.206028)')
  expect_equal(truth, unname(raw[[5]][c(2, 6)]))

})

test_that("conf.int", {

  raw <- modelsummary:::extract_models(mod, statistic = 'conf.int')

  truth <- c("[-2.873, -1.099]", "[0.421, 0.909]")
  expect_equal(truth, unname(raw[[4]][c(2, 4)]))

  truth <- c("[-2.760, 13.501]", "[-0.784, 0.131]")
  expect_equal(truth, unname(raw[[5]][c(2, 6)]))

})

test_that("conf.int, conf_level = 0.99", {

  raw <- modelsummary:::extract_models(mod, statistic = 'conf.int', conf_level = .99)

  truth <- c("[-3.181, -0.791]", "[0.336, 0.994]")
  expect_equal(truth, unname(raw[[4]][c(2, 4)]))

  truth <- c("[-5.070, 16.689]", "[-0.966, 0.259]")
  expect_equal(truth, unname(raw[[5]][c(2, 6)]))

})

#' sanity check: datasummary_table1
#'
#' @param formula
#' right-handed formulae only
sanity_ds_right_handed_formula <- function(formula) {
  termlabels <- labels(stats::terms(formula))
  if (length(termlabels) > 1) {
    stop("The 'table1' template for `datasummary` only accepts a single right-hand side variable of type factor, character, or logical. If you do not want to transform your variable in the original data, you can wrap it in a Factor() call: datasummary_table1(~Factor(x), data). the name of your variablePlease visit the `modelsummary` website to learn how to build your own, more complex, Table 1. It's easy, I promise! https://vincentarelbundock.github.io/modelsummary/datasummary.html")
  }
}
