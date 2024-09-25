
with CTE as
(
    select num,
lEAD(num,1)over(order by id)as lead1,
lEAD(num,2)over(order by id)as lead2
From Logs
)

select distinct num as ConsecutiveNums 
from CTE
where num=lead1 and num=lead2
