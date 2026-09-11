-- ============================================================
-- Digital Book Service — SQL Business Analysis
-- Portfolio version
-- ============================================================
-- This file contains the core SQL queries used in the project.
-- The original database credentials are intentionally excluded.
-- ============================================================


-- 1. Database table sizes
SELECT 'books' AS table_name, COUNT(*) AS row_count
FROM books

UNION ALL

SELECT 'authors' AS table_name, COUNT(*) AS row_count
FROM authors

UNION ALL

SELECT 'publishers' AS table_name, COUNT(*) AS row_count
FROM publishers

UNION ALL

SELECT 'ratings' AS table_name, COUNT(*) AS row_count
FROM ratings

UNION ALL

SELECT 'reviews' AS table_name, COUNT(*) AS row_count
FROM reviews;


-- 2. Number of books published after 1 January 2000
SELECT
    COUNT(*) AS books_after_2000
FROM books
WHERE publication_date > DATE '2000-01-01';


-- 3. Rating count, review count and average rating by book
WITH review_stats AS (
    SELECT
        book_id,
        COUNT(review_id) AS review_count
    FROM reviews
    GROUP BY book_id
),
rating_stats AS (
    SELECT
        book_id,
        COUNT(rating_id) AS rating_count,
        AVG(rating) AS avg_rating
    FROM ratings
    GROUP BY book_id
)
SELECT
    b.book_id,
    b.title,
    COALESCE(rts.rating_count, 0) AS rating_count,
    COALESCE(rs.review_count, 0) AS review_count,
    ROUND(rts.avg_rating, 2) AS avg_rating
FROM books AS b
LEFT JOIN rating_stats AS rts
    ON b.book_id = rts.book_id
LEFT JOIN review_stats AS rs
    ON b.book_id = rs.book_id
ORDER BY
    review_count DESC,
    avg_rating DESC,
    b.title;


-- 4. Publisher with the most books longer than 50 pages
SELECT
    p.publisher,
    COUNT(b.book_id) AS book_count
FROM publishers AS p
INNER JOIN books AS b
    ON p.publisher_id = b.publisher_id
WHERE b.num_pages > 50
GROUP BY
    p.publisher_id,
    p.publisher
ORDER BY book_count DESC
LIMIT 1;


-- 5. Highest-rated author among books with at least 50 ratings
WITH qualified_books AS (
    SELECT
        book_id
    FROM ratings
    GROUP BY book_id
    HAVING COUNT(rating_id) >= 50
)
SELECT
    a.author,
    ROUND(AVG(r.rating), 3) AS avg_rating
FROM authors AS a
INNER JOIN books AS b
    ON a.author_id = b.author_id
INNER JOIN ratings AS r
    ON b.book_id = r.book_id
INNER JOIN qualified_books AS qb
    ON b.book_id = qb.book_id
GROUP BY
    a.author_id,
    a.author
ORDER BY avg_rating DESC
LIMIT 1;


-- 6. Average number of reviews written by users
--    who rated more than 50 distinct books
WITH active_users AS (
    SELECT
        username
    FROM ratings
    GROUP BY username
    HAVING COUNT(DISTINCT book_id) > 50
),
review_counts AS (
    SELECT
        r.username,
        COUNT(r.text) AS review_count
    FROM reviews AS r
    INNER JOIN active_users AS au
        ON r.username = au.username
    GROUP BY r.username
)
SELECT
    ROUND(AVG(review_count), 2) AS avg_review_count
FROM review_counts;
