SELECT * FROM books.project_2;
use books;
#1 Check Availability of eBooks vs Physical Books;
SELECT isEbook, COUNT(*) AS book_count
FROM project_2
GROUP BY isEbook;

#2Find the Publisher with the Most Books Published;
SELECT book_authors AS publisher, COUNT(*) AS book_count
FROM project_2
GROUP BY book_authors
ORDER BY book_count DESC
LIMIT 1;

#3 Identify the Publisher with the Highest Average Rating;
SELECT book_authors AS publisher, AVG(averageRating) AS avg_rating
FROM project_2
GROUP BY book_authors
HAVING COUNT(*) > 10
ORDER BY avg_rating DESC
LIMIT 1;

#4 Get the Top 5 Most Expensive Books by Retail Price;
SELECT book_title, amount_retailPrice, currencyCode_retailPrice
FROM project_2
ORDER BY amount_retailPrice DESC
LIMIT 5;

#5 Find Books Published After 2010 with at Least 500 Pages;
SELECT book_title, book_authors, pageCount, year
FROM project_2
WHERE year > 2010 AND pageCount >= 500;

#6 List Books with Discounts Greater than 20%;
SELECT book_title, 
       amount_listPrice, 
       amount_retailPrice, 
       ((amount_listPrice - amount_retailPrice) / amount_listPrice) * 100 AS discount_percentage
FROM project_2
WHERE amount_listPrice > 0 AND amount_retailPrice < amount_listPrice AND 
      ((amount_listPrice - amount_retailPrice) / amount_listPrice) * 100 > 20;

#7 Find the Average Page Count for eBooks vs Physical Books;
SELECT isEbook, AVG(pageCount) AS avg_page_count
FROM project_2
GROUP BY isEbook;

#8 Find the Top 3 Authors with the Most Books;
SELECT book_authors, COUNT(*) AS book_count
FROM project_2
GROUP BY book_authors
ORDER BY book_count DESC
LIMIT 3;

#9 List Publishers with More than 10 Books;
SELECT book_authors AS publisher, COUNT(*) AS book_count
FROM project_2
GROUP BY book_authors
HAVING COUNT(*) > 10;

#10 Find the Average Page Count for Each Category;
SELECT categories, AVG(pageCount) AS avg_page_count
FROM project_2
GROUP BY categories;

#11 Retrieve Books with More than 3 Authors;
SELECT book_title, book_authors
FROM project_2
WHERE LENGTH(book_authors) - LENGTH(REPLACE(book_authors, ',', '')) + 1 > 3;

#12 Books with Ratings Count Greater Than the Average;
SELECT book_title, ratingsCount
FROM project_2
WHERE ratingsCount > (SELECT AVG(ratingsCount) FROM project_2);

#13 Books with the Same Author Published in the Same Year;
SELECT book_authors, year, COUNT(*) AS book_count
FROM project_2
GROUP BY book_authors, year
HAVING COUNT(*) > 1;

#14 Books with a Specific Keyword in the Title;
SELECT book_title, book_authors
FROM project_2
WHERE book_title LIKE '%keyword%';

#15 Year with the Highest Average Book Price;
SELECT year, AVG(amount_retailPrice) AS avg_price
FROM project_2
GROUP BY year
ORDER BY avg_price DESC
LIMIT 1;

#16 Count Authors Who Published 3 Consecutive Years;
SELECT book_authors, COUNT(DISTINCT year) AS consecutive_years
FROM project_2
GROUP BY book_authors
HAVING MAX(year) - MIN(year) >= 2;

#17 Write a SQL query to find authors who have published books in the same year but under different publishers. Return the authors, year, and the COUNT of books they published in that year.
;
SELECT book_authors, year, COUNT(DISTINCT book_authors) AS publisher_count
FROM project_2
GROUP BY book_authors, year
HAVING publisher_count > 1;

#18 Create a query to find the average amount_retailPrice of eBooks and physical books. Return a single result set with columns for avg_ebook_price and avg_physical_price. Ensure to handle cases where either category may have no entries.
;
SELECT 
    AVG(CASE WHEN isEbook = TRUE THEN amount_retailPrice END) AS avg_ebook_price,
    AVG(CASE WHEN isEbook = FALSE THEN amount_retailPrice END) AS avg_physical_price
FROM project_2;

#19 Write a SQL query to identify books that have an averageRating that is more than two standard deviations away from the average rating of all books. Return the title, averageRating, and ratingsCount for these outliers.
;
WITH stats AS (
    SELECT AVG(averageRating) AS avg_rating, STDDEV(averageRating) AS stddev_rating
    FROM project_2
)
SELECT book_title, averageRating, ratingsCount
FROM project_2, stats
WHERE averageRating > avg_rating + 2 * stddev_rating
   OR averageRating < avg_rating - 2 * stddev_rating;

#20 Create a SQL query that determines which publisher has the highest average rating among its books, but only for publishers that have published more than 10 books. Return the publisher, average_rating, and the number of books published.
;
SELECT book_authors AS publisher, AVG(averageRating) AS avg_rating, COUNT(*) AS book_count
FROM project_2
GROUP BY book_authors
HAVING COUNT(*) > 10
ORDER BY avg_rating DESC
LIMIT 1;






