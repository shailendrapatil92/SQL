/*Find the total amount of poster_qty paper ordered in the orders table.*/
SELECT
	SUM(poster_qty) total_post_qty
FROM
	orders

/*Find the total amount of standard_qty paper ordered in the orders table*/
SELECT
  SUM(standard_qty) total_std_qty
FROM
  orders

/*Find the total dollar amount of sales using the total_amt_usd in the orders table.*/
SELECT
	SUM(total_amt_usd) total_amount
FROM
	orders

/*Find the total amount spent on standard_amt_usd and gloss_amt_usd paper for each order in the orders table. This should give a dollar amount for each order in the table.*/
SELECT
	standard_amt_usd + gloss_amt_usd total_standard_gloss
FROM
	orders;

/*Find the standard_amt_usd per unit of standard_qty paper. Your solution should use both an aggregation and a mathematical operator.*/
SELECT
	SUM(standard_amt_usd)/SUM(standard_qty) std_per_unit
FROM
	orders


/*When was the earliest order ever placed? You only need to return the date.*/
SELECT
	MIN(occurred_at)
FROM
	orders

/*Try performing the same query as in question 1 without using an aggregation function. */
SELECT
	occurred_at
FROM
	orders
ORDER BY occurred_at
LIMIT 1

/*When did the most recent (latest) web_event occur?*/
SELECT
	max(occurred_at)
FROM
	web_events

/*Try to perform the result of the previous query without using an aggregation function.*/
SELECT
	occurred_at
FROM
	web_events
ORDER BY
	occurred_at desc
LIMIT 1

/*Which account (by name) placed the earliest order? Your solution should have the account name and the date of the order.*/
SELECT
	a.name,o.occurred_at
FROM
	accounts a
JOIN
	orders o
ON
	a.id=o.account_id
ORDER BY
	o.occurred_at
LIMIT 1

/*Find the total sales in usd for each account. You should include two columns - the total sales for each company's orders in usd and the company name.*/
SELECT a.name, SUM(total_amt_usd )
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.name


/*Via what channel did the most recent (latest) web_event occur, which account was associated with this web_event? Your query should return only three values - the date, channel, and account name.*/
SELECT w.occurred_at, w.channel, a.name
FROM web_events w
JOIN accounts a
ON w.account_id = a.id
ORDER BY w.occurred_at DESC
LIMIT 1;

/*Find the total number of times each type of channel from the web_events was used. Your final table should have two columns - the channel and the number of times the channel was used*/
SELECT
	channel,count(channel)
FROM
	web_events
GROUP BY
	channel

/*Who was the primary contact associated with the earliest web_event? */
SELECT
	a.primary_poc
FROM
	accounts a
JOIN
	web_events w
ON
	a.id=w.account_id
ORDER BY w.occurred_at
LIMIT 1

/*What was the smallest order placed by each account in terms of total usd. Provide only two columns - the account name and the total usd. Order from smallest dollar amounts to largest.*/
SELECT
	a.name, o.total_amt_usd
FROM
	accounts a
JOIN
	orders o
ON
	a.id = o.account_id
ORDER BY o.total_amt_usd
LIMIT 1


/*Find the number of sales reps in each region. Your final table should have two columns - the region and the number of sales_reps. Order from fewest reps to most reps.*/
SELECT
	r.name, count(s.id) no_sales_reps
FROM
	sales_reps s
JOIN
	region r
ON
	r.id = s.region_id
GROUP BY
	r.name

/*For each account, determine the average amount of each type of paper they purchased across their orders. Your result should have four columns - one for the account name and one for the average quantity purchased for each of the paper types for each account. */
SELECT
	a.name, AVG(o.standard_amt_usd) avg_std,AVG(o.gloss_amt_usd) avg_gloss,AVG(o.poster_amt_usd) avg_poster
FROM
	accounts a
JOIN
	orders o
ON
	a.id = o.account_id
GROUP BY a.name



/*For each account, determine the average amount spent per order on each paper type. Your result should have four columns - one for the account name and one for the average amount spent on each paper type.*/
SELECT
	a.name,AVG(standard_amt_usd) avg_std,AVG(gloss_amt_usd) avg_gloss, AVG(poster_amt_usd) avg_poster
FROM
	accounts a
JOIN
	orders o
ON
	a.id=o.account_id
GROUP BY
	a.name

/*Determine the number of times a particular channel was used in the web_events table for each sales rep. Your final table should have three columns - the name of the sales rep, the channel, and the number of occurrences. Order your table with the highest number of occurrences first.*/
SELECT
	sr.name,channel,count(channel) as count_channel
FROM
	accounts a
JOIN
	sales_reps sr
ON
	a.sales_rep_id = sr.id
JOIN
	web_events w
ON
	w.account_id = a.id
GROUP BY
	sr.name,w.channel


/*Determine the number of times a particular channel was used in the web_events table for each region. Your final table should have three columns - the region name, the channel, and the number of occurrences. Order your table with the highest number of occurrences first.*/
SELECT
	r.name,channel,count(channel) as count_channel
FROM
	accounts a
JOIN
	sales_reps sr
ON
	a.sales_rep_id = sr.id
JOIN
	web_events w
ON
	w.account_id = a.id
JOIN
	region r
ON
	r.id = sr.region_id
GROUP BY
	r.name,w.channel

/*How many of the sales reps have more than 5 accounts that they manage?*/
SELECT
	sr.name,count(a.id) AS number_accounts
FROM
	accounts a
JOIN
	sales_reps sr
ON
	a.sales_rep_id = sr.id
Group by
	sr.name
Having
    count(a.id)>5

/*How many accounts have more than 20 orders?*/
SELECT
	a.id, count(o.id)
FROM
	accounts a
JOIN
	orders o
ON
	a.id = o.account_id
GROUP BY
	a.id
HAVING
	count(o.id) > 20

/*Which account has the most orders?*/
SELECT
	a.id,a.name, count(o.id) as order_count
FROM
	accounts a
JOIN
	orders o
ON
	a.id = o.account_id
GROUP BY
	a.id
ORDER BY order_count DESC
LIMIT 1

/*How many accounts spent more than 30,000 usd total across all order*/
SELECT
	a.id, SUM(o.total_amt_usd) total_amt_used
FROM
	accounts a
JOIN
	orders o
ON
	a.id = o.account_id
GROUP BY
	a.id
HAVING
	SUM(o.total_amt_usd)>30000
ORDER BY
	a.id


/*How many accounts spent less than 1,000 usd total across all orders?*/
SELECT
	a.id, SUM(o.total_amt_usd) total_amt_used
FROM
	accounts a
JOIN
	orders o
ON
	a.id = o.account_id
GROUP BY
	a.id
HAVING
	SUM(o.total_amt_usd)<1000
ORDER BY
	a.id

	/*Which account has spent the most with us?*/
	SELECT
	a.id,a.name, SUM(o.total_amt_usd) total_amt_used
FROM
	accounts a
JOIN
	orders o
ON
	a.id = o.account_id
GROUP BY
	a.id,a.name
ORDER BY
	total_amt_used DESC
LIMIT 1

/*Which account has spent the least with us?*/
SELECT
a.id,a.name, SUM(o.total_amt_usd) total_amt_used
FROM
accounts a
JOIN
orders o
ON
a.id = o.account_id
GROUP BY
a.id,a.name
ORDER BY
total_amt_used
LIMIT 1




/*Which accounts used facebook as a channel to contact customers more than 6 times?*/
SELECT
	a.id, count(*) AS count_customer
FROM
    accounts a
JOIN
	web_events w
ON
	a.id = w.account_id
WHERE
	w.channel ='facebook'
GROUP BY
	a.id
HAVING
	count(*)>6

/*Which account used facebook most as a channel?*/
SELECT
	a.id,a.name,count(*) AS count_customer
FROM
    accounts a
JOIN
	web_events w
ON
	a.id = w.account_id
WHERE
	w.channel ='facebook'
GROUP BY
	a.id,a.name
ORDER BY
	count_customer DESC
LIMIT 1

/*Find the sales in terms of total dollars for all orders in each year, ordered from greatest to least.*/
SELECT
	DATE_TRUNC('year',occurred_at) AS Year,
    SUM(total_amt_usd) total_amount
FROM
	orders
GROUP BY
	1
ORDER BY
	2 DESC

/*Which month did Parch & Posey have the greatest sales in terms of total dollars?*/
SELECT
	DATE_TRUNC('month',occurred_at) AS Month,
    SUM(total_amt_usd) total_amount
FROM
	orders
GROUP BY
	1
ORDER BY
	2 DESC
LIMIT 1

/*Which year did Parch & Posey have the greatest sales in terms of total number of orders?*/
SELECT
	DATE_PART('year',DATE_TRUNC('year',occurred_at)) AS Year,
    SUM(total_amt_usd) total_amount
FROM
	orders
GROUP BY
	1
ORDER BY
	2 DESC
LIMIT 1

/*Which month did Parch & Posey have the greatest sales in terms of total number of orders?*/
SELECT
	DATE_PART('month',DATE_TRUNC('month',occurred_at)) AS Year,
    count(*) total_qty
FROM
	orders
GROUP BY
	1
ORDER BY
	2 DESC
LIMIT 1


/* We would like to understand 3 different levels of customers based on the amount associated with their purchases. The top branch includes anyone with a Lifetime Value (total sales of all orders) greater than 200,000 usd. The second branch is between 200,000 and 100,000 usd. The lowest branch is anyone under 100,000 usd. Provide a table that includes the level associated with each account. You should provide the account name, the total sales of all orders for the customer, and the level. Order with the top spending customers listed first.*/
SELECT
	a.name,sum(total_amt_usd) AS total_amt_spent,
    CASE WHEN SUM(total_amt_usd) > 200000 THEN 'top'
    	 WHEN SUM(total_amt_usd) > 100000 THEN 'mid'
         ELSE 'low' END AS Level
FROM
	accounts a
JOIN
	orders o
ON
	a.id = o.account_id
GROUP BY
		a.name
ORDER BY
	2 DESC


/* */
SELECT
	a.name,sum(total_amt_usd) AS total_amt_spent,
    CASE WHEN SUM(total_amt_usd) > 200000 THEN 'top'
    	 WHEN SUM(total_amt_usd) > 100000 THEN 'mid'
         ELSE 'low' END AS Level
FROM
	accounts a
JOIN
	orders o
ON
	a.id = o.account_id
WHERE (DATE_PART('year',occurred_at) =2016 OR DATE_PART('year',occurred_at) =2017)
GROUP BY
		a.name
ORDER BY
	2 DESC



/*We would like to identify top performing sales reps, which are sales reps associated with more than 200 orders. Create a table with the sales rep name, the total number of orders, and a column with top or not depending on if they have more than 200 orders. Place the top sales people first in your final table.*/
SELECT
	sr.name,count(*) as total_orders,
    CASE WHEN count(*) >200 THEN 'top'
    ELSE 'not' END AS performance
FROM
	sales_reps sr
JOIN
	accounts a
ON
	sr.id = a.sales_rep_id
JOIN
	orders o
ON
	o.account_id  = a.id
Group By
	sr.name

/*The previous didn't account for the middle, nor the dollar amount associated with the sales. Management decides they want to see these characteristics represented as well. We would like to identify top performing sales reps, which are sales reps associated with more than 200 orders or more than 750000 in total sales. The middle group has any rep with more than 150 orders or 500000 in sales. Create a table with the sales rep name, the total number of orders, total sales across all orders, and a column with top, middle, or low depending on this criteria. Place the top sales people based on dollar amount of sales first in your final table. You might see a few upset sales people by this criteria!*/
SELECT
	sr.name,
    count(*) as total_orders,
    SUM(o.total_amt_usd) total_spent,
    CASE WHEN count(*) >200 OR 				    SUM(o.total_amt_usd)>750000 THEN 'top'
    WHEN (count(*) <200 and count(*) >150) OR (SUM(o.total_amt_usd) > 500000 and SUM(o.total_amt_usd)<750000) THEN 'middle'
    ELSE 'not' END AS performance
FROM
	sales_reps sr
JOIN
	accounts a
ON
	sr.id = a.sales_rep_id
JOIN
	orders o
ON
	o.account_id  = a.id
Group By
	sr.name
