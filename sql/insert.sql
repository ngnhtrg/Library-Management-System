-- Insert data into readers --
INSERT INTO
    readers (reader_nm, phone_no, address_txt)
VALUES
    ('James Smith', '+1-484-457-8875', '132 My Street, Kingston, New York, United States'),
    ('Maria Garcia', '+1-573-896-7426', '94 Whitetail Lane, Dallas, Texas, United States'),
    ('Maria Rodriguez', '+1-559-245-5532', '3836 Edgewood Avenue, Fresno, California, United States'),
    ('Lopez Rodríguez', '+34-773-088-570', '50 Avda. de la Estación, Cadalso De Los Vidrios, Madrid, Spain'),
    ('David Brown', '+44-070-6288-7945', '99 Prestwick Road, Invergeldie, United Kingdom'),
    ('Alan Cowley', '+44-079-7862-2193', '50 Hexham Road, Denton,United Kingdom'),
    ('Steven Luke', '+44-070-3285-7161', '93 Abbey Row, Nynehead, United Kingdom'),
    ('Nick Kester', '+44-078-5667-6861', '74 Wartnaby Road, Addlethorpe, United Kingdom'),
    ('Brian Sims', '+1-954-987-0645', '226 Pointe Lane, Hollywood, Florida, United States'),
    ('Steven Luke', '+1-615-480-6990', '2907 Wilkinson Street, Nashville, Tennessee, United States');

-- Insert data into authors --
INSERT INTO
    authors (author_nm)
VALUES
    ('Elias M. Stein'),
    ('Rami Shakarchi'),
    ('Richard P. Feynman'),
    ('Theodore Brown'),
    ('H. LeMay'),
    ('Bruce Bursten'),
    ('Catherine Murphy'),
    ('Patrick Woodward'),
    ('Matthew Stoltzfus'),
    ('Martin Kleppmann'),
    ('Aurélien Géron'),
    ('Matthew Helmke'),
    ('Ryan Troy'),
    ('Joseph J. Rotman'),
    ('Gabe Brown'),
    ('Roxy Wilson'),
    ('Frederick Schauer'),
    ('Walter Shields'),
    ('Kevin W. Plaxco'),
    ('Michael Gross');

-- Insert data into categories --
INSERT INTO
    categories (category_nm)
VALUES
    ('Mathematics'),
    ('Physics'),
    ('Chemistry'),
    ('Biology & Life Sciences'),
    ('Agriculture'),
    ('Astronomy & Astrophysics'),
    ('Mechanics'),
    ('Computer Science'),
    ('Law'),
    ('Engineering');

-- Insert data into publishers --
INSERT INTO
    publishers (publisher_nm, phone_no, address_txt)
VALUES
    ('Princeton University Press', '+1 609 258 4900', '41 William Street, Princeton, United States'),
    ('Springer', '+1 800 777 4643', '11 West 42nd Street, Manhattan, New York, United States'),
    ('Basic Books', '+1 212 364 0669', '1290 Avenue of the Americas, New York, United States'),
    ('Pearson', '+1 300 473 277', '330 Hudson, New York City, New York, United States'),
    (E'O\'Reilly Media', '+44 20 3355 9998', 'Sebastopol, California, United States'),
    ('Addison-Wesley', '+44 1279 623623', 'Boston, United States'),
    ('Harvard University Press', '+1 617 495 2600', '79 Garden Street Cambridge, Massachusetts, United States'),
    ('ClydeBank Media LLC', '+1 888 2086826', 'Albany, New York, United States'),
    ('Johns Hopkins University Press', '+1 410 516 6987', 'Baltimore, Maryland, United States'),
    ('Acres U.S.A', '+1 970 392 4464', '603 8th St, Greeley, CO 80631, United States'),
    ('Book Bear', '+1 920 933 5339', 'West Brookfield, Massachusetts, United States');

-- Insert data into books --
INSERT INTO
    books (book_title, publisher_id, edition_num, language_txt, copies_cnt, remain_cnt)
VALUES
    ('Ubuntu Linux Unleashed 2021 Edition', 6, 14, 'English', 10, 10),
    ('Fourier Analysis: An Introduction (Princeton Lectures in Analysis', 1, 1, 'English', 5, 5),
    ('Solutions Manual to Exercises for Chemistry: The Central Science', 4, 14, 'English', 12, 12),
    ('VMware Cookbook: A Real-World Guide to Effective VMware Use', 5, 2, 'English', 8, 8),
    ('Hands-On Machine Learning with Scikit-Learn, Keras, and TensorFlow: ' ||
            'Concepts, Tools, and Techniques to Build Intelligent Systems', 5, 2, 'English', 21, 21),
    ('Hands-On Machine Learning with Scikit-Learn, Keras, and TensorFlow: ' ||
            'Concepts, Tools, and Techniques to Build Intelligent Systems', 5, 1, 'English', 15, 15),
    ('Six Not-So-Easy Pieces: Lectures On Symmetry, Relativity, and Space-Time', 11, 1, 'English', 10, 10),
    ('Designing Data-Intensive Applications: ' ||
            'The Big Ideas Behind Reliable, Scalable, and Maintainable Systems', 5, 1, 'English', 12, 12),
    ('An Introduction to Algebraic Topology', 2, 1, 'English', 25, 25),
    ('The Proof: Uses of Evidence in Law, Politics, and Everything Else', 7, 1, 'English', 10, 10),
    ('SQL QuickStart Guide', 8, 1, 'English', 9, 9),
    ('Astrobiology', 9, 3, 'English', 9, 9),
    ('The Feynman Lectures on Physics, Vol. 1', 3, 1, 'English', 11, 11),
    ('Dirt to Soil', 10, 1, 'English', 3, 3);

-- Insert data into issues --
INSERT INTO
    issues (book_id, reader_id, borrowed_from_dt, borrowed_to_dt, actual_return_dt)
VALUES
    (5, 2, '2018-01-15', '2019-01-15', '2018-05-12'),
    (8, 1, '2020-10-28', '2021-06-30', '2021-06-28'),
    (6, 5, '2019-04-16', '2020-04-16', '2019-12-5'),
    (9, 5, '2018-04-16', '2020-04-16', '2020-04-25'),
    (1, 10, '2021-06-22', '2022-06-22', NULL),
    (1, 7, '2021-07-18', '2022-07-18', '2022-05-12'),
    (5, 2, '2018-01-15', '2019-01-15', '2018-05-12'),
    (7, 4, '2019-09-01', '2020-06-30', '2020-06-30'),
    (8, 3, '2020-02-02', '2020-08-02', '2020-10-24'),
    (2, 3, '2020-01-17', '2021-01-17', '2020-07-08'),
    (4, 6, '2020-06-15', '2021-06-15', '2021-08-08'),
    (1, 8, '2018-11-02', '2019-11-02', '2019-10-28'),
    (9, 3, '2020-01-17', '2021-01-17', '2020-07-08'),
    (1, 8, '2019-12-15', '2020-12-15', '2021-02-13'),
    (5, 4, '2020-06-25', '2020-12-25', '2020-12-30'),
    (7, 2, '2018-09-01', '2019-06-30', '2019-06-27'),
    (1, 10, '2019-05-11', '2019-06-11', '2019-08-11'),
    (12, 10, '2019-05-11', '2019-06-11', '2019-08-11'),
    (13, 5, '2020-08-01', '2021-08-01', '2021-07-20'),
    (14, 2, '2018-07-19', '2019-03-15', '2019-05-15'),
    (12, 7, '2019-05-20', '2019-10-20', '2020-02-25'),
    (2, 10, '2020-08-20', '2021-08-20', '2022-01-30');

-- Insert data into fines --
INSERT INTO
    fines (issue_id, fine_dt, fine_amt)
VALUES
    (4, '2020-04-25', 10),
    (9, '2020-10-25', 30),
    (11, '2021-08-08', 20),
    (14, '2021-02-13', 20),
    (15, '2020-12-30', 10),
    (17, '2019-08-11', 20),
    (18, '2020-08-11', 20),
    (20, '2019-05-20', 20),
    (21, '2020-02-25', 50),
    (22, '2019-05-20', 50);

-- Insert data into book_author --
INSERT INTO
    book_author (book_id, author_id)
VALUES
    (1, 12),
    (2, 1),
    (2, 2),
    (3, 4),
    (3, 5),
    (3, 6),
    (3, 7),
    (3, 8),
    (3, 16),
    (4, 13),
    (4, 12),
    (5, 11),
    (6, 11),
    (7, 3),
    (8, 10),
    (9, 14),
    (10, 17),
    (11, 18),
    (12, 19),
    (12, 20),
    (13, 3),
    (14, 15);

-- Insert data into book_category --
INSERT INTO
  book_category (book_id, category_id)
VALUES
    (1, 8),
    (2, 1),
    (3, 3),
    (4, 8),
    (5, 1),
    (5, 8),
    (6, 1),
    (6, 8),
    (7, 2),
    (8, 8),
    (9, 1),
    (10, 9),
    (11, 8),
    (12, 6),
    (13, 2),
    (14, 5);
