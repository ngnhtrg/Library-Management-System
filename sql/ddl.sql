CREATE SCHEMA IF NOT EXISTS library;

CREATE TABLE IF NOT EXISTS readers (
    reader_id INTEGER GENERATED ALWAYS AS IDENTITY,
    reader_nm VARCHAR(128) NOT NULL,
    phone_no VARCHAR(128) NOT NULL,
    address_txt VARCHAR(128) NOT NULL,
    PRIMARY KEY (reader_id)
);

CREATE TABLE IF NOT EXISTS authors (
    author_id INTEGER GENERATED ALWAYS AS IDENTITY,
    author_nm VARCHAR(128) NOT NULL,
    PRIMARY KEY (author_id)
);

CREATE TABLE IF NOT EXISTS categories (
    category_id INTEGER GENERATED ALWAYS AS IDENTITY,
    category_nm VARCHAR(128) NOT NULL,
    PRIMARY KEY (category_id)
);

CREATE TABLE IF NOT EXISTS publishers (
    publisher_id INTEGER GENERATED ALWAYS AS IDENTITY,
    publisher_nm VARCHAR(128) NOT NULL,
    phone_no VARCHAR(128) NOT NULL,
    address_txt VARCHAR(128) NOT NULL,
    PRIMARY KEY (publisher_id)
);

CREATE TABLE IF NOT EXISTS books (
    book_id INTEGER GENERATED ALWAYS AS IDENTITY,
    book_title VARCHAR(128) NOT NULL,
    publisher_id INTEGER NOT NULL,
    edition_num INTEGER NOT NULL,
    language_txt VARCHAR(128) NOT NULL,
    copies_cnt INTEGER NOT NULL,
    remain_cnt INTEGER NOT NULL,
    PRIMARY KEY (book_id),
    FOREIGN KEY (publisher_id) REFERENCES publishers (publisher_id)
);

CREATE TABLE IF NOT EXISTS issues (
    issue_id INTEGER GENERATED ALWAYS AS IDENTITY,
    book_id INTEGER NOT NULL,
    reader_id INTEGER NOT NULL,
    borrowed_from_dt DATE NOT NULL,
    borrowed_to_dt DATE NOT NULL,
    actual_return_dt DATE,
    PRIMARY KEY (issue_id),
    FOREIGN KEY (book_id) REFERENCES books (book_id),
    FOREIGN KEY (reader_id) REFERENCES readers (reader_id)
);

CREATE TABLE IF NOT EXISTS fines (
    fine_id INTEGER GENERATED ALWAYS AS IDENTITY,
    issue_id INTEGER NOT NULL,
    fine_dt DATE NOT NULL,
    fine_amt INTEGER NOT NULL,
    PRIMARY KEY (fine_id),
    FOREIGN KEY (issue_id) REFERENCES issues (issue_id)
);

CREATE TABLE IF NOT EXISTS book_author (
    book_id INTEGER NOT NULL,
    author_id INTEGER NOT NULL,
    FOREIGN KEY (book_id) REFERENCES books (book_id),
    FOREIGN KEY (author_id) REFERENCES authors (author_id)
);

CREATE TABLE IF NOT EXISTS book_category (
    book_id INTEGER NOT NULL,
    category_id INTEGER NOT NULL,
    FOREIGN KEY (book_id) REFERENCES books (book_id),
    FOREIGN KEY (category_id) REFERENCES categories (category_id)
);