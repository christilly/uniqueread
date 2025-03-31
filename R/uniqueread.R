#Required packages
library("plyr")
library("dplyr")

#Read in Goodreads data
#GR_data <- read.csv("/Users/tillytran/Desktop/goodreads_library_export.csv", header = TRUE)
GR_data <- read.csv("/Users/tillytran/Desktop/sample_export.csv", header = TRUE)
GR_data

#Get rid of not readily useful data columns
GR_data <- GR_data %>% select(-c(Author.l.f, Additional.Authors, Binding, ISBN, ISBN13, Year.Published,
                                 Original.Publication.Year, Exclusive.Shelf, My.Review, Spoiler, Private.Notes,
                                 Owned.Copies, Bookshelves, Bookshelves.with.positions, Publisher))

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




