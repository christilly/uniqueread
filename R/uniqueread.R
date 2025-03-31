# Hello, world!
#
# This is an example function named 'hello'
# which prints 'Hello, world!'.
#
# You can learn more about package authoring with RStudio at:
#
#   https://r-pkgs.org
#
# Some useful keyboard shortcuts for package authoring:
#
#   Install Package:           'Cmd + Shift + B'
#   Check Package:             'Cmd + Shift + E'
#   Test Package:              'Cmd + Shift + T'

#Required packages
library("plyr")
library("dplyr")

#Read in Goodreads data
GR_data <- read.csv("/Users/tillytran/Desktop/goodreads_library_export.csv", header = TRUE)

#Get rid of not readily useful data columns
GR_data <- GR_data %>% select(-c(Author.l.f, Additional.Authors, Binding, ISBN, ISBN13, Year.Published, Original.Publication.Year, Exclusive.Shelf, My.Review, Spoiler, Private.Notes, Owned.Copies, Bookshelves, Bookshelves.with.positions, Publisher))


#Convert ratings of 0 in My.Rating to NA and remove those books
#If a book has a rating of 0, it was not rated yet because Goodreads only allows users to give the lowest rating of 1, so these books should be removed
GR_clean <- GR_data %>%
  mutate(My.Rating = na_if(My.Rating, 0)) %>%  # Convert 0 to NA
  filter(!is.na(My.Rating)) # Remove rows where My.Rating is NA
GR_clean



