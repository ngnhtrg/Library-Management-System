-- TRIGGER --

/* Function to update the number of remaining books */
CREATE OR REPLACE FUNCTION update_insert_issue() RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
    BEGIN
        IF (TG_OP = 'INSERT' OR TG_OP = 'UPDATE') THEN
            UPDATE books
            SET remain_cnt = copies_cnt - (SELECT count(*) FROM issues
                                           WHERE issues.book_id = NEW.book_id AND actual_return_dt IS NULL)
            WHERE books.book_id = NEW.book_id;
            RETURN NEW;
        ELSIF (TG_OP = 'DELETE') THEN
            UPDATE books
            SET remain_cnt = copies_cnt - (SELECT count(*) FROM issues
                                           WHERE issues.book_id = OLD.book_id AND actual_return_dt IS NULL)
            WHERE books.book_id = OLD.book_id;
            RETURN OLD;
        END IF;
    END
$$;

/* Call function update_insert_issue to log updates of books, but only if something changed */
CREATE TRIGGER book_update
AFTER INSERT OR UPDATE OR DELETE ON issues
FOR EACH ROW
EXECUTE PROCEDURE update_insert_issue();

SELECT * FROM issues;
/* book_id 9 on table books before inserting into issue
+-------+---------------------------------------------+------------+-----------+------------+----------+----------+
|book_id|book_title                                   |publisher_id|edition_num|language_txt|copies_cnt|remain_cnt|
+-------+---------------------------------------------+------------+-----------+------------+----------+----------+
|9      |An Introduction to Algebraic Topology        |2           |1          |English     |25        |25        |
+-------+---------------------------------------------+------------+-----------+------------+----------+----------+
*/

INSERT INTO issues (book_id, reader_id, borrowed_from_dt, borrowed_to_dt, actual_return_dt)
VALUES (9, 5, '2020-01-02', '2020-05-01', NULL);

SELECT * FROM issues;
/* book_id 9 on table books after inserting into issue
+-------+---------------------------------------------+------------+-----------+------------+----------+----------+
|book_id|book_title                                   |publisher_id|edition_num|language_txt|copies_cnt|remain_cnt|
+-------+---------------------------------------------+------------+-----------+------------+----------+----------+
|9      |An Introduction to Algebraic Topology        |2           |1          |English     |25        |24        |
+-------+---------------------------------------------+------------+-----------+------------+----------+----------+
*/


/* Function to insert data into fines */
CREATE OR REPLACE FUNCTION update_return_book() RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
    BEGIN
        IF (TG_OP = 'INSERT' OR TG_OP = 'UPDATE') THEN
            IF (NEW.actual_return_dt IS NOT NULL AND
                NEW.actual_return_dt > NEW.borrowed_to_dt
                AND NEW.issue_id NOT IN (SELECT issue_id FROM fines)) THEN
                INSERT INTO fines (issue_id, fine_dt, fine_amt)
                VALUES (NEW.issue_id, NEW.actual_return_dt,
                        ((NEW.actual_return_dt - NEW.borrowed_to_dt) / 30 + 1) * 10);
            END IF;
            RETURN NEW;
        ELSIF (TG_OP = 'DELETE') THEN
            DELETE FROM fines WHERE fines.issue_id = OLD.issue_id;
            RETURN OLD;
        END IF;
    END
$$;

/* Execute the function update_return_book after updating and inserting into table issues */
CREATE TRIGGER fine_insert_update
AFTER UPDATE OR INSERT ON issues
FOR EACH ROW
EXECUTE PROCEDURE update_return_book();

/* Execute the function update_return_book after before deleting data from table issues */
CREATE TRIGGER fine_delete
BEFORE DELETE ON issues
FOR EACH ROW
EXECUTE PROCEDURE update_return_book();

SELECT * FROM fines;
/* Table fines before updating on issues
+-------+--------+----------+--------+
|fine_id|issue_id|fine_dt   |fine_amt|
+-------+--------+----------+--------+
|1      |4       |2020-04-25|10      |
|2      |9       |2020-10-25|30      |
|3      |11      |2021-08-08|20      |
|4      |14      |2021-02-13|20      |
|5      |15      |2020-12-30|10      |
|6      |17      |2019-08-11|20      |
|8      |20      |2019-05-20|20      |
|9      |21      |2020-02-25|50      |
|10     |22      |2019-05-20|50      |
|11     |23      |2019-05-20|10      |
+-------+--------+----------+--------+
*/

/* Update on table issues */
UPDATE issues SET actual_return_dt = '2020-05-05' WHERE issue_id = 24;
SELECT * FROM fines;
/* Table fines after updating on issues
+-------+--------+----------+--------+
|fine_id|issue_id|fine_dt   |fine_amt|
+-------+--------+----------+--------+
|1      |4       |2020-04-25|10      |
|2      |9       |2020-10-25|30      |
|3      |11      |2021-08-08|20      |
|4      |14      |2021-02-13|20      |
|5      |15      |2020-12-30|10      |
|6      |17      |2019-08-11|20      |
|8      |20      |2019-05-20|20      |
|9      |21      |2020-02-25|50      |
|10     |22      |2019-05-20|50      |
|11     |23      |2019-05-20|10      |
|12     |24      |2020-05-05|10      |
+-------+--------+----------+--------+
*/

/* Delete row from table issues */
DELETE FROM issues WHERE issue_id = 24;
SELECT * FROM fines;
/* Table fines after deleting on issues
+-------+--------+----------+--------+
|fine_id|issue_id|fine_dt   |fine_amt|
+-------+--------+----------+--------+
|1      |4       |2020-04-25|10      |
|2      |9       |2020-10-25|30      |
|3      |11      |2021-08-08|20      |
|4      |14      |2021-02-13|20      |
|5      |15      |2020-12-30|10      |
|6      |17      |2019-08-11|20      |
|8      |20      |2019-05-20|20      |
|9      |21      |2020-02-25|50      |
|10     |22      |2019-05-20|50      |
|11     |23      |2019-05-20|10      |
+-------+--------+----------+--------+
*/