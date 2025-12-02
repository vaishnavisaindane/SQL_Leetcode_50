select product_id, new_price as price
from Products
where (product_id,change_date)in(
    select product_id, max(change_date)
    from Products
    where change_date<='2019-08-16'
    group by product_id
)
union
select product_id, 10 as price
from Products
where (product_id)not in(
    select product_id
    from Products
    where change_date<='2019-08-16'
    group by product_id
)

# better approach 

SELECT 
    p.product_id,
    COALESCE(pp.new_price, 10) AS price
FROM (SELECT DISTINCT product_id FROM Products) p
LEFT JOIN Products pp
  ON p.product_id = pp.product_id
 AND pp.change_date = (
      SELECT MAX(change_date)
      FROM Products
      WHERE product_id = p.product_id
        AND change_date <= '2019-08-16'
 );

