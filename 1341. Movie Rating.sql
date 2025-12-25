#solution1
  WITH user_cnt AS (
    SELECT
        u.name,
        COUNT(mr.rating) AS cnt,
        ROW_NUMBER() OVER (ORDER BY COUNT(mr.rating) DESC, u.name) AS rn
    FROM Users u
    JOIN MovieRating mr
        ON u.user_id = mr.user_id
    GROUP BY u.user_id, u.name
),
movie_avg AS (
    SELECT
        m.title,
        AVG(mr.rating) AS avg_rating,
        ROW_NUMBER() OVER (ORDER BY AVG(mr.rating) DESC, m.title) AS rn
    FROM Movies m
    JOIN MovieRating mr
        ON m.movie_id = mr.movie_id
    WHERE mr.created_at >= '2020-02-01'
      AND mr.created_at < '2020-03-01'
    GROUP BY m.movie_id, m.title
)

SELECT name AS results
FROM user_cnt
WHERE rn = 1

UNION ALL

SELECT title AS results
FROM movie_avg
WHERE rn = 1;

#solution2

# Write your MySQL query statement below
# Write your MySQL query statement below
(select u.name as results
from Users u left join MovieRating mr
on u.user_id =mr.user_id
group by u.user_id
order by count(mr.rating) desc , u.name
limit 1)

UNION all

(
select m.title as results
from Movies m left join MovieRating mr
on m.movie_id =mr.movie_id
where extract(year_month from mr.created_at) = 202002
group by m.movie_id
order by avg(mr.rating) desc , m.title
limit 1  

)



