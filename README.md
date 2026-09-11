# SQL Business Analysis — Digital Book Service

A SQL-focused business analysis of a digital book service, exploring catalogue trends, reader ratings, written reviews, publisher activity, author performance, and highly engaged users.

## About the Project

This project analyses the relational database of a fictional digital book service.

The goal was to use SQL to understand both the **catalogue** and **reader behaviour**, and to translate those findings into insights that could support a new reading-related product.

Unlike several of my other portfolio projects, the analytical logic here is intentionally centred on **SQL**. pandas is used only to display query results inside the notebook.

## Business Questions

The analysis answers five main questions:

1. How many books were published after 1 January 2000?
2. How many ratings and written reviews does each book have, and what is its average rating?
3. Which publisher has the largest number of books longer than 50 pages?
4. Which author has the highest average rating among books with at least 50 ratings?
5. How many written reviews do highly active raters produce on average?

## Database Structure

The analysis uses five main tables:

- `books` — **1,000 records**
- `authors` — **636 records**
- `publishers` — **340 records**
- `ratings` — **6,456 records**
- `reviews` — **2,793 records**

The `books` table acts as the central catalogue table.

Key relationships include:

- `authors.author_id` → `books.author_id`
- `publishers.publisher_id` → `books.publisher_id`
- `books.book_id` → `ratings.book_id`
- `books.book_id` → `reviews.book_id`

## SQL Skills Demonstrated

This project includes practical use of:

- `SELECT`
- `WHERE`
- `JOIN` and `LEFT JOIN`
- `GROUP BY`
- `HAVING`
- `ORDER BY`
- `COUNT`
- `COUNT(DISTINCT ...)`
- `AVG`
- `ROUND`
- `COALESCE`
- Common Table Expressions (`WITH`)
- multi-table relational analysis
- aggregation before joins to avoid duplicated results

## Key Findings

### Catalogue recency

**819 books** were published after 1 January 2000.

This shows that a large share of the catalogue consists of relatively recent titles.

### Ratings and written reviews

The analysis combined rating volume, written-review volume, and average rating for all **1,000 books**.

**Twilight (Twilight #1)** had the highest number of written reviews, with **7**, and an average rating of **3.66**.

By comparison, **Harry Potter and the Prisoner of Azkaban** had **6 reviews** and a higher average rating of **4.41**.

This is a useful reminder that popularity, rating score, and depth of engagement are related but distinct signals.

### Leading publisher

**Penguin Books** had the largest number of books longer than 50 pages, with **42 titles**.

### Highest-rated author in the qualified sample

Among authors whose qualifying books received at least 50 ratings, **J.K. Rowling/Mary GrandPré** had the highest average rating:

**4.287**

The minimum-rating threshold makes this result more meaningful than an average based on only a small number of users.

### Highly engaged readers

Users who rated more than 50 books wrote an average of approximately:

**24.33 written reviews per user**

This suggests that highly active raters can also be important contributors to community-generated content.

## Business Perspective

The results show how catalogue information becomes more valuable when it is combined with reader behaviour.

Books and authors that combine **strong ratings with meaningful interaction volumes** could be useful signals for recommendation and discovery features.

Highly active readers may also be a valuable audience for community features, review programmes, or engagement initiatives.

For me, one of the most important lessons from the analysis is that an average score should rarely be interpreted alone. The volume of ratings and reviews adds important context to how popular or reliable that score really is.

## What I Learned

What I enjoyed most in this project was using SQL to move directly from a relational database to business insights.

It strengthened my understanding of joins, CTEs, aggregation, `GROUP BY`, `HAVING`, and `COUNT(DISTINCT ...)`, while also reinforcing the importance of structuring queries carefully.

One example was the book-level analysis: ratings and reviews were aggregated separately before being joined to the book table. This avoids multiplying rows and producing misleading counts, a small technical decision that makes a big difference to the quality of the result.
