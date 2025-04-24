# uniqueread

## Goals of the package
The goal of the uniqueread package is to analyze Goodreads data and give insight into how a Goodreads user rates the books they read. 
This package computes residual data by comparing the user's rating of a book to the average Goodreads rating of that book.  The output 
includes the average residual rating of the user (whether the user tended to rate the books higher or lower on average),  residual 
standard deviation (how dispersed the ratings of the user are), the book title associated with the maximum residual (the book the user 
has the highest difference in rating compared to the average Goodreads rating AKA the book they loved more than average), and the 
minimum residual (the book the user lowest difference in rating compared to the average Goodreads rating AKA the book they hated
more tha average). Lastly, the package displays a histogram of the distribution of ratings. Books the user tended to score higher than 
the average Goodreads rating are on the right of the 0, while books the user tended to score lower than the average Goodreads rating 
are on the left of the 0.

## Using the package
To learn how to export your Goodreads data for use in this package, please read through this [link](https://help.goodreads.com/s/article/How-do-I-import-or-export-my-books-1553870934590). 
