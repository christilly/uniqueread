test_that("clean_GR_ratings removes ratings of 0", {
  #Example data frame with books and ratings of 0
  sample_data <- data.frame(
    Title = c("Book 1", "Book 2", "Book 3", "Book 4", "Book 5"),
    My.Rating = c(1, 3, 0, 5, 0),
    stringsAsFactors = FALSE
  )

GR_clean <- clean_GR_ratings(sample_data)

#Test: My.Rating column should not have any 0 or NA values
expect_false(any(GR_clean$My.Rating == 0, na.rm = TRUE))
expect_false(any(is.na(GR_clean$My.Rating)))
})
