#Required packages
library("dplyr")
library("ggplot2")


#' Title: Read in GoodReads data from CSV file
#' Description: This function reads in data from user GoodReads CSV file
#' into a data frame and removes unnecessary columns.
#'
#' @param file_path A character string representing the file path. If `NULL`, sample data is used.
#' @return A data frame containing the cleaned Goodreads data.
#' @export
read_GR_data <- function(file_name = NULL) {
  # If no file is provided, use the sample data from the package
  if (is.null(file_name)) {
    # Get the file path for the sample data from the package
    file_name <- "sample_export.csv"
    file_path <- system.file("extdata", file_name, package = "uniqueread")

    if (file_path == "") {
      stop("Error: Sample file not found. Please check the package installation.")
    }
    cat("Using sample data from: ", file_path, "\n")
  } else {
    # If a file path is provided by the user, use it
    if (!file.exists(file_name)) {
      stop("Error: File not found. Please check the file path.")
    }
    file_path <- file_name
    cat("Using user-provided data from: ", file_path, "\n")
  }
  data <- read.csv(file_path, header = TRUE, stringsAsFactors = FALSE)

  #Remove unnecessary columns
  data <- data %>% select(-c(Author.l.f, Additional.Authors, Binding, ISBN, ISBN13, Year.Published,
                             Original.Publication.Year, Exclusive.Shelf, My.Review, Spoiler, Private.Notes,
                             Owned.Copies, Bookshelves, Bookshelves.with.positions, Publisher))
  cat("Data successfully loaded from: ", file_path, "\n")
  return(data)
}


#' Title: Remove ratings of 0 from GR_data
#'
#' Description: If a book has a rating of 0, it was not rated yet because Goodreads
#' only allows users to give the lowest rating of 1, so these books should be removed
#'
#' @param data_frame data frame with relevant Goodreads data.
#' @return A data frame with ratings of 0 removed.
#' @export
clean_GR_ratings <- function(data_frame) {
  data_frame %>%
    dplyr::mutate(My.Rating = na_if(My.Rating, 0)) %>%
    dplyr::filter(!is.na(My.Rating))
}


#' Title: Calculate residuals of the user rating - average Goodreads rating
#'
#' Description: Calculate the residuals of average Goodreads rating - user rating.
#'
#' @param data_frame cleaned data frame (GR_clean).
#' @return a data frame with residuals.
#' @export
calculate_residuals <- function(data_frame) {
  data_frame %>%
    dplyr::mutate(residuals = My.Rating - Average.Rating)
}


#' Title: Calculate average, standard deviation, highest, and lowest residuals
#'
#' Description: Using the residuals data in the data frame,
#' calculate the average residual score, as well as the highest
#' and lowest scores.
#'
#' @param data_frame data frame with residuals data.
#' @return average, highest, and lowest residual data and titles associated with data.
#' @export
res_data <- function(data_frame) {
  avg_res <- mean(data_frame$residuals, na.rm = TRUE)
  sd_res <- sd(data_frame$residuals, na.rm = TRUE)
  hr <- max(data_frame$residuals, na.rm = TRUE)
  lr <- min(data_frame$residuals, na.rm = TRUE)

  hr_title <- data_frame$Title[which(data_frame$residuals == hr)][1]
  lr_title <- data_frame$Title[which(data_frame$residuals == lr)][1]

  cat("On average, your book ratings differed from average Goodreads users by",
      round(avg_res, 4), "points with a standard deviation of", round(sd_res, 4),  "\n")
  cat("The book you loved more than others:", hr_title,
      "with a rating difference of", round(hr, 2), "stars\n")
  cat("The book you hated more than others:", lr_title,
      "with a rating difference of", round(lr, 2), "stars\n")
}


#' Title: Distribution histogram
#'
#' Description: Visually displays distribution histogram to see if user tends to be
#' more positive or negative than average Goodreads users.
#'
#' @param data_frame data frame with residuals data.
#' @return A distribution histogram.
#' @export
dist_hist <- function(data_frame) {
  ggplot2::ggplot(data = data_frame, ggplot2::aes(x = residuals)) +
    ggplot2::geom_histogram(binwidth = 0.5, fill = "steelblue", color = "black") +
    ggplot2::geom_vline(xintercept = 0, linetype = "dashed", color = "red") +
    ggplot2::labs(
      title = "Distribution of Rating Residuals",
      x = "Residuals (My Rating - Average Rating)",
      y = "Frequency"
    ) +
    ggplot2::theme_classic()
}
