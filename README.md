# 📚 Library Management System (LMS) - SQL Database

A relational database project designed in MySQL to manage authors, book inventory, and member registrations, featuring operational constraint checks and key business analytical queries.

---

## 📌 Project Overview

This project implements a normalized relational database schema for a Library Management System (LMS). It handles core library operations, maintains data integrity through relational constraints, and extracts operational insights such as inventory utilization, checkout rates, and member status distributions.

---

## 🗄️ Database Architecture & Schema

The schema consists of three primary entities:

1. **`authors`**: Stores author identifiers, full names, and nationality.
2. **`books`**: Tracks book titles, author linkage (`author_id`), publication years, and physical stock (`total_copies`, `available_copies`).
   - *Integrity Constraints*: Restricts deletion of authors with existing books (`ON DELETE RESTRICT`), validates publication years (`> 1400`), and enforces non-negative copy counts (`CHECK >= 0`).
3. **`members`**: Tracks registered patrons, email uniqueness, joining dates, and membership status (`active`, `suspended`, `expired`).

```sql
-- Schema Summary
authors (author_id [PK], first_name, last_name, nationality)
books (book_id [PK], title, author_id [FK], published_year, total_copies, available_copies)
members (members_id [PK], first_name, last_name, email [UNIQUE], phone, joined_date, status)
