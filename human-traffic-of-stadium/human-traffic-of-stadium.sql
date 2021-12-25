# Write your MySQL query statement below

WITH consecutives AS (
SELECT id, visit_date, people,
    LAG(id,2) OVER (ORDER BY visit_date) AS Day_Before_Yesterday,
    LAG(id,1) OVER (ORDER BY visit_date) AS Yesterday,
    LEAD(id,1) OVER (ORDER BY visit_date) AS Tomorrow,
    LEAD(id,2) OVER (ORDER BY visit_date) AS Day_After_Tomorrow
FROM Stadium
WHERE people>=100
)

SELECT consecutives.id, consecutives.visit_date, consecutives.people
FROM consecutives
WHERE 
    (consecutives.id + 1 = consecutives.Tomorrow AND consecutives.id +2 =           consecutives.Day_After_Tomorrow) 
        OR
    (consecutives.id-1 = consecutives.Yesterday AND consecutives.id + 1 = consecutives.Tomorrow)
        OR
    (consecutives.id-2 = consecutives.Day_Before_Yesterday AND consecutives.id - 1 =consecutives.Yesterday);
