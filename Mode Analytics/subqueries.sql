/*Provide the name of the sales_rep in each region with the largest amount of total_amt_usd sale*/

select
	t1.region,t2.sale_rep,total_amt
from
	(select
		region,max(sub.total_amt) max_total
	from
	  (select
	      r.name region,sr.name sale_rep,SUM(o.total_amt_usd) total_amt
	  from
	      sales_reps sr
	  JOIN
	      accounts a
	  ON
	      sr.id = a.sales_rep_id
	  JOIN
	      orders o
	  ON
	      a.id = o.account_id
	  JOIN
	      region r
	  ON
	      sr.region_id = r.id
	  GROUP BY
	      r.name,sr.name
	  ORDER BY
	      3 desc) sub
	GROUP BY
		1) t1
JOIN
	(select
	      r.name region,sr.name sale_rep,SUM(o.total_amt_usd) total_amt
	  from
	      sales_reps sr
	  JOIN
	      accounts a
	  ON
	      sr.id = a.sales_rep_id
	  JOIN
	      orders o
	  ON
	      a.id = o.account_id
	  JOIN
	      region r
	  ON
	      sr.region_id = r.id
	  GROUP BY
	      r.name,sr.name
	  ORDER BY
	      3 desc) t2
ON
	t1.max_total = t2.total_amt
	AND
	t2.region=t1.region





/*For the region with the largest (sum) of sales total_amt_usd, how many total (count) orders were placed?
*/
select
	r.name region,count(o.total) total_orders
from
	sales_reps sr
JOIN
	accounts a
ON
	sr.id = a.sales_rep_id
JOIN
	orders o
ON
	a.id = o.account_id
JOIN
	region r
ON
	sr.region_id = r.id
GROUP BY
	r.name
HAVING
		SUM(o.total_amt_usd) = (select max(total_amt)
														from
													(select r.name region,
												     	SUM(o.total_amt_usd) total_amt
													 from
														 sales_reps sr
													  JOIN
														  accounts a
													  ON
														   sr.id = a.sales_rep_id
													  JOIN
														   orders o
													  ON
														   a.id = o.account_id
													  JOIN
														   region r
													  ON
														   sr.region_id = r.id
													  GROUP BY
														    r.name
														        ORDER BY
														            1 desc) sub)
