-- QUERIES --


/* Find all publishers that have more than 1 book in the database */
SELECT publishers.publisher_nm, count(*)
FROM books INNER JOIN publishers
ON books.publisher_id = publishers.publisher_id
GROUP BY books.publisher_id, publishers.publisher_nm
HAVING count(*) > 1
ORDER BY books.publisher_id;
/* Query result
+--------------+-----+
|publisher_nm  |count|
+--------------+-----+
|O'Reilly Media|4    |
+--------------+-----+
*/


/* Use rank() function to assign a rank to each book by its number of copies */
SELECT
    book_title,
    copies_cnt,
    rank() OVER (ORDER BY copies_cnt DESC) copies_rank
FROM books;
/* Query result
 +-----------------------------------------+----------+-----------+
|book_title                                |copies_cnt|copies_rank|
+------------------------------------------+----------+-----------+
|An Introduction to Algebraic Topology     |25        |1          |
|Hands-On Machine Learning with Scikit-L...|21        |2          |
|Solutions Manual to Exercises for Chemi...|15        |3          |
|Hands-On Machine Learning with Scikit-L...|15        |3          |
|Designing Data-Intensive Applications: ...|12        |5          |
|The Feynman Lectures on Physics, Vol. 1   |11        |6          |
|Ubuntu Linux Unleashed 2021 Edition       |10        |7          |
|Six Not-So-Easy Pieces: Lectures On Sym...|10        |7          |
|The Proof: Uses of Evidence in Law, Pol...|10        |7          |
|SQL QuickStart Guide                      |9         |10         |
|Astrobiology                              |9         |10         |
|VMware Cookbook: A Real-World Guide to ...|8         |12         |
|Fourier Analysis: An Introduction (Prin...|5         |13         |
|Dirt to Soil                              |3         |14         |
+------------------------------------------+----------+-----------+
*/


/* Number of borrowed books by category */
SELECT DISTINCT c.category_id, c.category_nm, count(*) OVER (PARTITION BY bc.category_id)
FROM issues INNER JOIN books ON issues.book_id = books.book_id
INNER JOIN book_category bc ON books.book_id = bc.book_id
INNER JOIN categories c ON c.category_id = bc.category_id;
/* Query result
+-----------+------------------------+-----+
|category_id|category_nm             |count|
+-----------+------------------------+-----+
|1          |Mathematics             |9    |
|2          |Physics                 |3    |
|5          |Agriculture             |1    |
|6          |Astronomy & Astrophysics|1    |
|8          |Computer Science        |13   |
+-----------+------------------------+-----+
*/


/* Total fine */
SELECT readers.reader_id, reader_nm, sum(fine_amt)
FROM readers INNER JOIN issues ON readers.reader_id = issues.reader_id
INNER JOIN fines ON issues.issue_id = fines.issue_id
GROUP BY readers.reader_id
ORDER BY sum(fine_amt) DESC;
/* Query result
+---------+---------------+---+
|reader_id|reader_nm      |sum|
+---------+---------------+---+
|10       |Steven Luke    |70 |
|7        |Steven Luke    |50 |
|3        |Maria Rodriguez|30 |
|8        |Nick Kester    |20 |
|6        |Alan Cowley    |20 |
|2        |Maria Garcia   |20 |
|1        |James Smith    |10 |
|5        |David Brown    |10 |
|4        |Lopez Rodríguez|10 |
+---------+---------------+---+
*/


/* Use dense_rank() function to assign a rank to each publisher by its number of books in the database */
SELECT *, dense_rank() OVER (ORDER BY cnt DESC)
FROM (SELECT publishers.publisher_id, publishers.publisher_nm, count(*) cnt
FROM books INNER JOIN publishers ON books.publisher_id = publishers.publisher_id
GROUP BY publishers.publisher_id) tb;
/* Query result
+------------+------------------------------+---+----------+
|publisher_id|publisher_nm                  |cnt|dense_rank|
+------------+------------------------------+---+----------+
|5           |O'Reilly Media                |4  |1         |
|10          |Acres U.S.A                   |1  |2         |
|6           |Addison-Wesley                |1  |2         |
|2           |Springer                      |1  |2         |
|11          |Book Bear                     |1  |2         |
|9           |Johns Hopkins University Press|1  |2         |
|7           |Harvard University Press      |1  |2         |
|3           |Basic Books                   |1  |2         |
|1           |Princeton University Press    |1  |2         |
|4           |Pearson                       |1  |2         |
|8           |ClydeBank Media LLC           |1  |2         |
+------------+------------------------------+---+----------+
*/


/* Rank the reader's favorite category*/
SELECT reader_id, reader_nm, category_nm, dense_rank() OVER (PARTITION BY reader_id ORDER BY issue_cnt)
FROM (SELECT r.reader_id, reader_nm, c.category_nm, count(issue_id) issue_cnt
FROM issues INNER JOIN books b ON b.book_id = issues.book_id
INNER JOIN readers r ON issues.reader_id = r.reader_id
INNER JOIN book_category bc ON b.book_id = bc.book_id
INNER JOIN categories c ON c.category_id = bc.category_id
GROUP BY r.reader_id, c.category_id) tb;
/* Query result
+---------+---------------+------------------------+----------+
|reader_id|reader_nm      |category_nm             |dense_rank|
+---------+---------------+------------------------+----------+
|1        |James Smith    |Mathematics             |1         |
|1        |James Smith    |Computer Science        |2         |
|2        |Maria Garcia   |Agriculture             |1         |
|2        |Maria Garcia   |Physics                 |1         |
|2        |Maria Garcia   |Mathematics             |2         |
|2        |Maria Garcia   |Computer Science        |2         |
|3        |Maria Rodriguez|Computer Science        |1         |
|3        |Maria Rodriguez|Mathematics             |2         |
|4        |Lopez Rodríguez|Computer Science        |1         |
|4        |Lopez Rodríguez|Mathematics             |1         |
|4        |Lopez Rodríguez|Physics                 |1         |
|5        |David Brown    |Physics                 |1         |
|5        |David Brown    |Computer Science        |1         |
|5        |David Brown    |Mathematics             |2         |
|6        |Alan Cowley    |Computer Science        |1         |
|7        |Steven Luke    |Astronomy & Astrophysics|1         |
|7        |Steven Luke    |Computer Science        |1         |
|8        |Nick Kester    |Computer Science        |1         |
|10       |Steven Luke    |Mathematics             |1         |
|10       |Steven Luke    |Computer Science        |2         |
+---------+---------------+------------------------+----------+
*/
