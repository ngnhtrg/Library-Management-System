/*
CRUD    SQL
Create  INSERT
Read    SELECT
Update  UPDATE
Delete  DELETE
*/

-- INSERT --
INSERT INTO issues (book_id, reader_id, borrowed_from_dt, borrowed_to_dt, actual_return_dt)
VALUES (5, 1, '2020-03-08', '2020-08-08', '2020-10-01');
INSERT INTO fines (issue_id, fine_dt, fine_amt) VALUES (23, '2019-05-20', 10);
INSERT INTO categories (category_nm) VALUES ('Economy');

-- SELECT --
SELECT * FROM issues WHERE issues.actual_return_dt IS NOT NULL;
/* Query result
+--------+-------+---------+----------------+--------------+----------------+
|issue_id|book_id|reader_id|borrowed_from_dt|borrowed_to_dt|actual_return_dt|
+--------+-------+---------+----------------+--------------+----------------+
|1       |5      |2        |2018-01-15      |2019-01-15    |2018-05-12      |
|2       |8      |1        |2020-10-28      |2021-06-30    |2021-06-28      |
|3       |6      |5        |2019-04-16      |2020-04-16    |2019-12-05      |
|4       |9      |5        |2018-04-16      |2020-04-16    |2020-04-25      |
|6       |1      |7        |2021-07-18      |2022-07-18    |2022-05-12      |
|7       |5      |2        |2018-01-15      |2019-01-15    |2018-05-12      |
|8       |7      |4        |2019-09-01      |2020-06-30    |2020-06-30      |
|9       |8      |3        |2020-02-02      |2020-08-02    |2020-10-24      |
|10      |2      |3        |2020-01-17      |2021-01-17    |2020-07-08      |
|11      |4      |6        |2020-06-15      |2021-06-15    |2021-08-08      |
|12      |1      |8        |2018-11-02      |2019-11-02    |2019-10-28      |
|13      |9      |3        |2020-01-17      |2021-01-17    |2020-07-08      |
|14      |1      |8        |2019-12-15      |2020-12-15    |2021-02-13      |
|15      |5      |4        |2020-06-25      |2020-12-25    |2020-12-30      |
|16      |7      |2        |2018-09-01      |2019-06-30    |2019-06-27      |
|17      |1      |10       |2019-05-11      |2019-06-11    |2019-08-11      |
|18      |12     |10       |2019-05-11      |2019-06-11    |2019-08-11      |
|19      |13     |5        |2020-08-01      |2021-08-01    |2021-07-20      |
|20      |14     |2        |2018-07-19      |2019-03-15    |2019-05-15      |
|21      |12     |7        |2019-05-20      |2019-10-20    |2020-02-25      |
|22      |2      |10       |2020-08-20      |2021-08-20    |2022-01-30      |
|23      |5      |1        |2020-03-08      |2020-08-08    |2020-10-01      |
+--------+-------+---------+----------------+--------------+----------------+
*/

SELECT authors.author_id, author_nm, book_title
FROM authors INNER JOIN book_author ON authors.author_id = book_author.author_id
INNER JOIN books b on b.book_id = book_author.book_id
ORDER BY author_id;
/* Query result
+---------+------------------+------------------------------------------+
|author_id|author_nm         |book_title                                |
+---------+------------------+------------------------------------------+
|1        |Elias M. Stein    |Fourier Analysis: An Introduction (Prin...|
|2        |Rami Shakarchi    |Fourier Analysis: An Introduction (Prin...|
|3        |Richard P. Feynman|The Feynman Lectures on Physics, Vol. 1   |
|3        |Richard P. Feynman|Six Not-So-Easy Pieces: Lectures On Sym...|
|4        |Theodore Brown    |Solutions Manual to Exercises for Chemi...|
|5        |H. LeMay          |Solutions Manual to Exercises for Chemi...|
|6        |Bruce Bursten     |Solutions Manual to Exercises for Chemi...|
|7        |Catherine Murphy  |Solutions Manual to Exercises for Chemi...|
|8        |Patrick Woodward  |Solutions Manual to Exercises for Chemi...|
|10       |Martin Kleppmann  |Designing Data-Intensive Applications: ...|
|11       |Aurélien Géron    |Hands-On Machine Learning with Scikit-L...|
|11       |Aurélien Géron    |Hands-On Machine Learning with Scikit-L...|
|12       |Matthew Helmke    |Ubuntu Linux Unleashed 2021 Edition       |
|12       |Matthew Helmke    |VMware Cookbook: A Real-World Guide to ...|
|13       |Ryan Troy         |VMware Cookbook: A Real-World Guide to ...|
|14       |Joseph J. Rotman  |An Introduction to Algebraic Topology     |
|15       |Gabe Brown        |Dirt to Soil                              |
|16       |Roxy Wilson       |Solutions Manual to Exercises for Chemi...|
|17       |Frederick Schauer |The Proof: Uses of Evidence in Law, Pol...|
|18       |Walter Shields    |SQL QuickStart Guide                      |
|19       |Kevin W. Plaxco   |Astrobiology                              |
|20       |Michael Gross     |Astrobiology                              |
+---------+------------------+------------------------------------------+
 */

-- UPDATE --
UPDATE books SET copies_cnt = 15 WHERE book_id = 3;
UPDATE readers SET phone_no = '+1-954-236-4815' WHERE reader_id = 9;
UPDATE readers SET address_txt = '142 Leisure Lane, San Luis Obispo, California, United States' WHERE reader_id = 2;

-- DELETE --
DELETE FROM fines WHERE fine_id = 7;
DELETE FROM issues WHERE issue_id = 18;
