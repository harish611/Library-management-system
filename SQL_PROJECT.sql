LIBRARY MANAGEMENT SYSTEM (LMS)       

USE library_db

CREATE TABLE authors (
    author_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50) ,
    nationality VARCHAR(50)
)


CREATE TABLE books (
    book_id INT  PRIMARY KEY,
    title VARCHAR(150) ,
    author_id INT NOT NULL,
    published_year INT CHECK (published_year > 1400),
    total_copies INT NOT NULL DEFAULT 1 CHECK (total_copies >= 0),
    available_copies INT NOT NULL DEFAULT 1 CHECK (available_copies >= 0),
    CONSTRAINT fk_books_authors FOREIGN KEY (author_id) 
        REFERENCES authors(author_id) 
        ON DELETE RESTRICT
)


CREATE TABLE members (
    members_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20),
    joined_date DATE NOT NULL DEFAULT (CURRENT_DATE),
    status ENUM('active', 'suspended', 'expired') DEFAULT 'active'
)



INSERT INTO authors (author_id ,first_name, last_name, nationality) VALUES
(1,'George', 'Orwell', 'British'),
(2,'Frank', 'Herbert', 'American'),
(3,'Harper', 'Lee', 'American')


INSERT INTO books ( Book_id,title,  author_id, published_year, total_copies, available_copies) VALUES
(22,'windows down',1, 1949, 5, 4),
(23,'Animal Farm',  2, 1945, 3, 3),
(24,'Dune', 3, 1965, 4, 3)


INSERT INTO members (members_id,first_name, last_name, email, phone, joined_date, status) VALUES
(57328,'Alice', 'Johnson', 'alice@example.com', '555-0101', '2025-01-15', 'active'),
(57742,'Bob', 'Smith', 'bob@example.com', '555-0102', '2025-02-10', 'active'),
(57872,'Charlie', 'Brown', 'charlie@example.com', '555-0103', '2025-03-01', 'active')


select*from members

SELECT 
    b.book_id,
    b.title,
    CONCAT(a.first_name, ' ', a.last_name) AS author_name,
    a.nationality,
    b.published_year,
    b.total_copies,
    b.available_copies
FROM books b
JOIN authors a ON b.author_id = a.author_id
ORDER BY b.title ASC

SELECT 
    b.title,
    b.total_copies,
    b.available_copies,
    (b.total_copies - b.available_copies) AS borrowed_copies,
    ROUND(((b.total_copies - b.available_copies) / b.total_copies) * 100, 1) AS checkout_rate_pct
FROM books b
WHERE b.available_copies < b.total_copies


SELECT 
    CONCAT(a.first_name, ' ', a.last_name) AS author_name,
    a.nationality,
    COUNT(b.book_id) AS total_titles,
    COALESCE(SUM(b.total_copies), 0) AS total_physical_inventory,
    COALESCE(SUM(b.available_copies), 0) AS available_physical_inventory
FROM authors a
LEFT JOIN books b ON a.author_id = b.author_id
GROUP BY a.author_id, a.first_name, a.last_name, a.nationality
ORDER BY total_physical_inventory DESC



SELECT 
    status,
    COUNT(members_id) AS total_members,
    MIN(joined_date) AS earliest_joined_date,
    MAX(joined_date) AS newest_joined_date,
    ROUND(COUNT(members_id) * 100.0 / (SELECT COUNT(*) FROM members), 2) AS pct_of_membership
FROM members
GROUP BY status




SELECT 
    CONCAT(a.first_name, ' ', a.last_name) AS non_american_author,
    a.nationality,
    b.title,
    b.published_year
FROM authors a
JOIN books b ON a.author_id = b.author_id
WHERE a.nationality != 'American'




select * from authors

select * from members

select * from books
