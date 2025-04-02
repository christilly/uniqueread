#Required packages
library("plyr")
library("dplyr")


#' Title: Read in and clean GoodReads data from CSV file
#'
#' Description: This function reads in data from user GoodReads CSV file
#' into a data frame and removes unnecessary columns.
#'
#' @param file_path A character string representing the path to the CSV file.
#' @return A data frame containing the cleaned Goodreads data.
#' @export
read_GR_data <- function(file_path) {
  if (!file.exists(file_path)) {
    stop("Error: File not found. Please check the file path.")
  }
  data <- read.csv(file_path, header = TRUE, stringsAsFactors = FALSE)
  #Remove unnecessary columns
  data <- data %>% select(-c(Author.l.f, Additional.Authors, Binding, ISBN, ISBN13, Year.Published,
                             Original.Publication.Year, Exclusive.Shelf, My.Review, Spoiler, Private.Notes,
                             Owned.Copies, Bookshelves, Bookshelves.with.positions, Publisher))
  cat("Data successfully loaded from: ", file_path, "\n")
  return(data)
}

GR_data <- read_GR_data("/Users/tillytran/Desktop/goodreads_library_export.csv")

#Testing
#GR_data <- read_GR_data("/Users/tillytran/Desktop/goodreads_library_export.csv")
#GR_data <- read_GR_data("/Users/tillytran/Desktop/sample_export.csv")


#Convert ratings of 0 in My.Rating to NA and remove those books
#If a book has a rating of 0, it was not rated yet because Goodreads only allows users to give the lowest rating of 1, so these books should be removed
GR_clean <- GR_data %>%
  mutate(My.Rating = na_if(My.Rating, 0)) %>%  # Convert 0 to NA
  filter(!is.na(My.Rating)) # Remove rows where My.Rating is NA
GR_clean

#calculate residuals of average rating - user rating
GR_clean <- GR_clean %>%
  mutate(residuals = My.Rating - Average.Rating)

#Calculate average residual score
avg_res <- mean(GR_clean$residuals)
cat("On average, your book ratings differed from average Goodreads users by:", avg_res, "points")

#Highest residual (greatest positive difference in user vs average rating)
hr <- max(GR_clean$residuals)
#Lowest residual (greatest negative difference in user vs average rating)
lr <- min(GR_clean$residuals)

#Print titles of highest and lowest residuals
hr_title <- GR_clean$Title[which(GR_clean$residuals == hr)]
lr_title <- GR_clean$Title[which(GR_clean$residuals == lr)]
cat("The book you loved that everyone else hated:", hr_title, "with a rating difference of", hr, "stars", "\n")
cat("The book you hated that everyone else loved:", lr_title, "with a rating difference of", lr, "stars", "\n")




