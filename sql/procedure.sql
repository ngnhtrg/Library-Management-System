-- PROCEDURE --

/* Inserting data using a procedure */
CREATE OR REPLACE PROCEDURE insert_reader (name VARCHAR(128), phone VARCHAR(128), address VARCHAR(128))
LANGUAGE SQL
AS $$
    INSERT INTO readers (reader_nm, phone_no, address_txt)
    VALUES (name, phone, address);
$$;

CALL insert_reader('Joel Bell ', '+1-714-667-4627', '3526 Alpaca Way, Santa Ana, California, United States');

SELECT * FROM readers;
/*
 +---------+---------------+-----------------+--------------------------------------------------------------+
|reader_id|reader_nm      |phone_no         |address_txt                                                   |
+---------+---------------+-----------------+--------------------------------------------------------------+
|1        |James Smith    |+1-484-457-8875  |132 My Street, Kingston, New York, United States              |
|3        |Maria Rodriguez|+1-559-245-5532  |3836 Edgewood Avenue, Fresno, California, United States       |
|4        |Lopez Rodríguez|+34-773-088-570  |50 Avda. de la Estación, Cadalso De Los Vidrios, Madrid, Spain|
|5        |David Brown    |+44-070-6288-7945|99 Prestwick Road, Invergeldie, United Kingdom                |
|6        |Alan Cowley    |+44-079-7862-2193|50 Hexham Road, Denton,United Kingdom                         |
|7        |Steven Luke    |+44-070-3285-7161|93 Abbey Row, Nynehead, United Kingdom                        |
|8        |Nick Kester    |+44-078-5667-6861|74 Wartnaby Road, Addlethorpe, United Kingdom                 |
|10       |Steven Luke    |+1-615-480-6990  |2907 Wilkinson Street, Nashville, Tennessee, United States    |
|9        |Brian Sims     |+1-954-236-4815  |226 Pointe Lane, Hollywood, Florida, United States            |
|2        |Maria Garcia   |+1-573-896-7426  |142 Leisure Lane, San Luis Obispo, California, United States  |
|11       |Joel Bell      |+1-714-667-4627  |3526 Alpaca Way, Santa Ana, California, United States         |
+---------+---------------+-----------------+--------------------------------------------------------------+
*/


/* Displaying a message on the screen */
CREATE OR REPLACE PROCEDURE display_message (INOUT message TEXT)
LANGUAGE plpgsql
AS $$
    BEGIN
        RAISE NOTICE 'Procedure Parameter: %', message;
    END;
$$;

CALL display_message('This is my test case');
/*
+--------------------+
|message             |
+--------------------+
|This is my test case|
+--------------------+
 */
