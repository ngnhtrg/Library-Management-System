-- VIEW --

/* Hiding the reader's phone number*/
CREATE VIEW v_reader AS
SELECT reader_id, reader_nm,  LEFT(phone_no, -3) || '***' AS phone_no
FROM readers;
/*
+---------+---------------+-----------------+
|reader_id|reader_nm      |phone_no         |
+---------+---------------+-----------------+
|1        |James Smith    |+1-484-457-8***  |
|3        |Maria Rodriguez|+1-559-245-5***  |
|4        |Lopez Rodríguez|+34-773-088-***  |
|5        |David Brown    |+44-070-6288-7***|
|6        |Alan Cowley    |+44-079-7862-2***|
|7        |Steven Luke    |+44-070-3285-7***|
|8        |Nick Kester    |+44-078-5667-6***|
|10       |Steven Luke    |+1-615-480-6***  |
|9        |Brian Sims     |+1-954-236-4***  |
|2        |Maria Garcia   |+1-573-896-7***  |
+---------+---------------+-----------------+
*/


/* Hiding the publisher's phone number*/
CREATE VIEW v_publisher AS
SELECT publisher_id, publisher_nm,  LEFT(phone_no, -3) || '***' AS phone_no
FROM publishers;
/*
+------------+------------------------------+----------------+
|publisher_id|publisher_nm                  |phone_no        |
+------------+------------------------------+----------------+
|1           |Princeton University Press    |+1 609 258 4*** |
|2           |Springer                      |+1 800 777 4*** |
|3           |Basic Books                   |+1 212 364 0*** |
|4           |Pearson                       |+1 300 473 ***  |
|5           |O'Reilly Media                |+44 20 3355 9***|
|6           |Addison-Wesley                |+44 1279 623*** |
|7           |Harvard University Press      |+1 617 495 2*** |
|8           |ClydeBank Media LLC           |+1 888 2086***  |
|9           |Johns Hopkins University Press|+1 410 516 6*** |
|10          |Acres U.S.A                   |+1 970 392 4*** |
|11          |Book Bear                     |+1 920 933 5*** |
+------------+------------------------------+----------------+
*/


/* List all issues for each reader */
CREATE VIEW v_reader_issue AS
SELECT readers.reader_id, reader_nm, issue_id, book_title, borrowed_from_dt, borrowed_to_dt, actual_return_dt
FROM readers INNER JOIN issues i ON readers.reader_id = i.reader_id
INNER JOIN books ON i.book_id = books.book_id
ORDER BY reader_id, issue_id;
/*
+---------+---------------+--------+------------------------------------------+----------------+--------------+----------------+
|reader_id|reader_nm      |issue_id|book_title                                |borrowed_from_dt|borrowed_to_dt|actual_return_dt|
+---------+---------------+--------+------------------------------------------+----------------+--------------+----------------+
|1        |James Smith    |2       |Designing Data-Intensive Applications: ...|2020-10-28      |2021-06-30    |2021-06-28      |
|1        |James Smith    |23      |Hands-On Machine Learning with Scikit-L...|2020-03-08      |2020-08-08    |2020-10-01      |
|2        |Maria Garcia   |1       |Hands-On Machine Learning with Scikit-L...|2018-01-15      |2019-01-15    |2018-05-12      |
|2        |Maria Garcia   |7       |Hands-On Machine Learning with Scikit-L...|2018-01-15      |2019-01-15    |2018-05-12      |
|2        |Maria Garcia   |16      |Six Not-So-Easy Pieces: Lectures On Sym...|2018-09-01      |2019-06-30    |2019-06-27      |
|2        |Maria Garcia   |20      |Dirt to Soil                              |2018-07-19      |2019-03-15    |2019-05-15      |
|3        |Maria Rodriguez|9       |Designing Data-Intensive Applications: ...|2020-02-02      |2020-08-02    |2020-10-24      |
|3        |Maria Rodriguez|10      |Fourier Analysis: An Introduction (Prin...|2020-01-17      |2021-01-17    |2020-07-08      |
|3        |Maria Rodriguez|13      |An Introduction to Algebraic Topology     |2020-01-17      |2021-01-17    |2020-07-08      |
|4        |Lopez Rodríguez|8       |Six Not-So-Easy Pieces: Lectures On Sym...|2019-09-01      |2020-06-30    |2020-06-30      |
|4        |Lopez Rodríguez|15      |Hands-On Machine Learning with Scikit-L...|2020-06-25      |2020-12-25    |2020-12-30      |
|5        |David Brown    |3       |Hands-On Machine Learning with Scikit-L...|2019-04-16      |2020-04-16    |2019-12-05      |
|5        |David Brown    |4       |An Introduction to Algebraic Topology     |2018-04-16      |2020-04-16    |2020-04-25      |
|5        |David Brown    |19      |The Feynman Lectures on Physics, Vol. 1   |2020-08-01      |2021-08-01    |2021-07-20      |
|6        |Alan Cowley    |11      |VMware Cookbook: A Real-World Guide to ...|2020-06-15      |2021-06-15    |2021-08-08      |
|7        |Steven Luke    |6       |Ubuntu Linux Unleashed 2021 Edition       |2021-07-18      |2022-07-18    |2022-05-12      |
|7        |Steven Luke    |21      |Astrobiology                              |2019-05-20      |2019-10-20    |2020-02-25      |
|8        |Nick Kester    |12      |Ubuntu Linux Unleashed 2021 Edition       |2018-11-02      |2019-11-02    |2019-10-28      |
|8        |Nick Kester    |14      |Ubuntu Linux Unleashed 2021 Edition       |2019-12-15      |2020-12-15    |2021-02-13      |
|10       |Steven Luke    |5       |Ubuntu Linux Unleashed 2021 Edition       |2021-06-22      |2022-06-22    |NULL            |
|10       |Steven Luke    |17      |Ubuntu Linux Unleashed 2021 Edition       |2019-05-11      |2019-06-11    |2019-08-11      |
|10       |Steven Luke    |22      |Fourier Analysis: An Introduction (Prin...|2020-08-20      |2021-08-20    |2022-01-30      |
+---------+---------------+--------+------------------------------------------+----------------+--------------+----------------+
*/


/* Detail information about fines */
CREATE VIEW v_fines_info AS
SELECT fine_id, fines.issue_id, fine_dt, fine_amt, readers.reader_id, reader_nm, books.book_id, book_title
FROM fines INNER JOIN issues ON fines.issue_id = issues.issue_id
INNER JOIN books ON issues.book_id = books.book_id
INNER JOIN readers ON issues.reader_id = readers.reader_id;
/*
+-------+--------+----------+--------+---------+---------------+-------+------------------------------------------+
|fine_id|issue_id|fine_dt   |fine_amt|reader_id|reader_nm      |book_id|book_title                                |
+-------+--------+----------+--------+---------+---------------+-------+------------------------------------------+
|1      |4       |2020-04-25|10      |5        |David Brown    |9      |An Introduction to Algebraic Topology     |
|2      |9       |2020-10-25|30      |3        |Maria Rodriguez|8      |Designing Data-Intensive Applications: ...|
|3      |11      |2021-08-08|20      |6        |Alan Cowley    |4      |VMware Cookbook: A Real-World Guide to ...|
|4      |14      |2021-02-13|20      |8        |Nick Kester    |1      |Ubuntu Linux Unleashed 2021 Edition       |
|5      |15      |2020-12-30|10      |4        |Lopez Rodríguez|5      |Hands-On Machine Learning with Scikit-L...|
|6      |17      |2019-08-11|20      |10       |Steven Luke    |1      |Ubuntu Linux Unleashed 2021 Edition       |
|8      |20      |2019-05-20|20      |2        |Maria Garcia   |14     |Dirt to Soil                              |
|9      |21      |2020-02-25|50      |7        |Steven Luke    |12     |Astrobiology                              |
|10     |22      |2019-05-20|50      |10       |Steven Luke    |2      |Fourier Analysis: An Introduction (Prin...|
|11     |23      |2019-05-20|10      |1        |James Smith    |5      |Hands-On Machine Learning with Scikit-L...|
+-------+--------+----------+--------+---------+---------------+-------+------------------------------------------+
*/


/* Statistics on the number of books by publishers */
CREATE VIEW v_publisher_cnt_books AS
SELECT publishers.publisher_id, publishers.publisher_nm, count(*) books_cnt
FROM books INNER JOIN publishers ON books.publisher_id = publishers.publisher_id
GROUP BY publishers.publisher_id;
/*
+------------+------------------------------+---------+
|publisher_id|publisher_nm                  |books_cnt|
+------------+------------------------------+---------+
|4           |Pearson                       |1        |
|10          |Acres U.S.A                   |1        |
|6           |Addison-Wesley                |1        |
|2           |Springer                      |1        |
|11          |Book Bear                     |1        |
|9           |Johns Hopkins University Press|1        |
|7           |Harvard University Press      |1        |
|3           |Basic Books                   |1        |
|1           |Princeton University Press    |1        |
|5           |O'Reilly Media                |4        |
|8           |ClydeBank Media LLC           |1        |
+------------+------------------------------+---------+
*/


/* Detail information about books */
CREATE VIEW v_books_info AS
SELECT
    books.book_id,
    book_title,
    books.publisher_id,
    publisher_nm,
    edition_num,
    language_txt,
    copies_cnt,
    remain_cnt,
    authors.author_id, author_nm
FROM books INNER JOIN publishers ON books.publisher_id = publishers.publisher_id
INNER JOIN book_author ON books.book_id = book_author.book_id
INNER JOIN authors ON book_author.author_id = authors.author_id;
/*
+-------+------------------------------------------+------------+------------------------------+-----------+------------+----------+----------+---------+------------------+
|book_id|book_title                                |publisher_id|publisher_nm                  |edition_num|language_txt|copies_cnt|remain_cnt|author_id|author_nm         |
+-------+------------------------------------------+------------+------------------------------+-----------+------------+----------+----------+---------+------------------+
|1      |Ubuntu Linux Unleashed 2021 Edition       |6           |Addison-Wesley                |14         |English     |10        |10        |12       |Matthew Helmke    |
|2      |Fourier Analysis: An Introduction (Prin...|1           |Princeton University Press    |1          |English     |5         |5         |1        |Elias M. Stein    |
|2      |Fourier Analysis: An Introduction (Prin...|1           |Princeton University Press    |1          |English     |5         |5         |2        |Rami Shakarchi    |
|3      |Solutions Manual to Exercises for Chemi...|4           |Pearson                       |14         |English     |15        |12        |4        |Theodore Brown    |
|3      |Solutions Manual to Exercises for Chemi...|4           |Pearson                       |14         |English     |15        |12        |5        |H. LeMay          |
|3      |Solutions Manual to Exercises for Chemi...|4           |Pearson                       |14         |English     |15        |12        |6        |Bruce Bursten     |
|3      |Solutions Manual to Exercises for Chemi...|4           |Pearson                       |14         |English     |15        |12        |7        |Catherine Murphy  |
|3      |Solutions Manual to Exercises for Chemi...|4           |Pearson                       |14         |English     |15        |12        |8        |Patrick Woodward  |
|3      |Solutions Manual to Exercises for Chemi...|4           |Pearson                       |14         |English     |15        |12        |16       |Roxy Wilson       |
|4      |VMware Cookbook: A Real-World Guide to ...|5           |O'Reilly Media                |2          |English     |8         |8         |13       |Ryan Troy         |
|4      |VMware Cookbook: A Real-World Guide to ...|5           |O'Reilly Media                |2          |English     |8         |8         |12       |Matthew Helmke    |
|5      |Hands-On Machine Learning with Scikit-L...|5           |O'Reilly Media                |2          |English     |21        |21        |11       |Aurélien Géron    |
|6      |Hands-On Machine Learning with Scikit-L...|5           |O'Reilly Media                |1          |English     |15        |15        |11       |Aurélien Géron    |
|7      |Six Not-So-Easy Pieces: Lectures On Sym...|11          |Book Bear                     |1          |English     |10        |10        |3        |Richard P. Feynman|
|8      |Designing Data-Intensive Applications: ...|5           |O'Reilly Media                |1          |English     |12        |12        |10       |Martin Kleppmann  |
|9      |An Introduction to Algebraic Topology     |2           |Springer                      |1          |English     |25        |25        |14       |Joseph J. Rotman  |
|10     |The Proof: Uses of Evidence in Law, Pol...|7           |Harvard University Press      |1          |English     |10        |10        |17       |Frederick Schauer |
|11     |SQL QuickStart Guide                      |8           |ClydeBank Media LLC           |1          |English     |9         |9         |18       |Walter Shields    |
|12     |Astrobiology                              |9           |Johns Hopkins University Press|3          |English     |9         |9         |19       |Kevin W. Plaxco   |
|12     |Astrobiology                              |9           |Johns Hopkins University Press|3          |English     |9         |9         |20       |Michael Gross     |
|13     |The Feynman Lectures on Physics, Vol. 1   |3           |Basic Books                   |1          |English     |11        |11        |3        |Richard P. Feynman|
|14     |Dirt to Soil                              |10          |Acres U.S.A                   |1          |English     |3         |3         |15       |Gabe Brown        |
+-------+------------------------------------------+------------+------------------------------+-----------+------------+----------+----------+---------+------------------+
*/
