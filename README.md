# uniqueread

## Goals of the package
The goal of the uniqueread package is to analyze Goodreads data and give insight into how a Goodreads user rates the books they read. This package computes residual data by comparing the user's rating of a book to the average Goodreads rating of that book.  The output includes the average residual rating of the user (whether the user tended to rate the books higher or lower on average),  residual standard deviation (how dispersed the ratings of the user are), the book title associated with the maximum residual (the book the user gave the highest difference in rating compared to the average Goodreads rating AKA the book they loved more than average), and the minimum residual (the book the user gave the most negative difference in rating compared to the average Goodreads rating AKA the book they hated more than average). Lastly, the package displays a histogram of the distribution of ratings. Books the user tended to score higher than the average Goodreads rating are on the right of the 0, while books the user tended to score lower than the average Goodreads rating are on the left of the 0.

## Using the package
To learn how to export your Goodreads data for use in this package, please read through this [link](https://help.goodreads.com/s/article/How-do-I-import-or-export-my-books-1553870934590). For a step by step rundown of the code and how to use it, please access this [link](https://rpubs.com/christilly/1301939). You need to input the file path of your data into the read_GR_data function. If you do not wish to use your own Goodreads data, you can download the example data from this package called sample_export.csv. 

### Important things to note
While the ideas and work within this package are my own, please note that AI was used to assist in correcting errors in my code. 
