context("huxtable")

library(dplyr)
library(modelsummary)

models <- list()
models[['OLS 1']] <- lm(hp ~ mpg + wt, mtcars)
models[['Poisson 1']] <- glm(hp ~ mpg + drat, mtcars, family = poisson())
models[['OLS 2']] <- lm(vs ~ hp + wt, mtcars)
models[['Logit 1']] <- glm(vs ~ hp + drat, mtcars, family = binomial())
models[['Logit 2']] <- glm(am ~ hp + disp, mtcars, family = binomial())

test_that("markdown caption and notes", {
  unknown <- expect_warning(
    msummary(models, "huxtable", title = "test title", notes = "test note",
      stars = TRUE) %>%
      huxtable::to_md())
  expect_known_output(cat(unknown), "known_output/huxtable-title-notes.md")
})


test_that("save to file", {

  options(modelsummary_html = 'huxtable')
  options(modelsummary_rtf = 'huxtable')
  options(modelsummary_latex = 'huxtable')
  options(modelsummary_word = 'huxtable')
  options(modelsummary_powerpoint = 'huxtable')

  random <- stringi::stri_rand_strings(1, 30)

  filename <- paste0(random, '.html')
  expect_error(msummary(models, filename), NA)
  unlink(filename)

  filename <- paste0(random, '.rtf')
  expect_error(msummary(models, filename), NA)
  unlink(filename)

  filename <- paste0(random, '.tex')
  expect_error(msummary(models, filename), NA)
  unlink(filename)

  filename <- paste0(random, '.docx')
  expect_error(msummary(models, filename), NA)
  unlink(filename)

  filename <- paste0(random, '.pptx')
  expect_error(msummary(models, filename), NA)
  unlink(filename)

  options(modelsummary_html = 'kableExtra')
  options(modelsummary_rtf = 'gt')
  options(modelsummary_latex = 'kableExtra')
  options(modelsummary_word = 'flextable')
  options(modelsummary_powerpoint = 'flextable')

})
