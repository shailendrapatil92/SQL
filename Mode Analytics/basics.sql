
/*Pull the first 5 rows and all columns from the orders table that have a dollar amount of gloss_amt_usd greater than or equal to 1000.*/
SELECT
	*
FROM
	orders
WHERE
	gloss_amt_usd >1000
LIMIT 5;


/*Pull the first 10 rows and all columns from the orders table that have a total_amt_usd less than 500.*/
SELECT
	*
FROM
	orders
WHERE
	total_amt_usd<500
LIMIT 10;

/*Filter the accounts table to include the company name, website, and the primary point of contact (primary_poc) for Exxon Mobil in the accounts table.*/
SELECT
	name,website,primary_poc
FROM
	accounts
WHERE
	primary_poc='Exxon Mobil'


/*Create a column that divides the standard_amt_usd by the standard_qty to find the unit price for standard paper for each order. Limit the results to the first 10 orders, and include the id and account_id fields. */
SELECT
	id,account_id,standard_amt_usd/standard_qty AS standard_unit_price
FROM
	orders
LIMIT 10



/*All the companies whose names start with 'C'. */
SELECT
	*
FROM
	accounts
WHERE
	name like 'C%'

/*All companies whose names contain the string 'one' somewhere in the name.*/
SELECT
	*
FROM
	accounts
WHERE
	name like '%one%'


/*All companies whose names end with 's'. */
SELECT
	*
FROM
	accounts
WHERE
	name like '%s'

/*Use the accounts table to find the account name, primary_poc, and sales_rep_id for Walmart, Target, and Nordstrom.*/
SELECT
	name,primary_poc,sales_rep_id
FROM
    accounts
where
	name IN ('Walmart','Target','Nordstrom');

/*Use the web_events table to find all information regarding individuals who were contacted via the channel of organic or adwords*/
SELECT
	*
FROM
	web_events
where
	channel IN ('organic','adwords')

/*Use the accounts table to find the account name, primary poc, and sales rep id for all stores except Walmart, Target, and Nordstrom.*/
SELECT
	name,primary_poc,sales_rep_id
FROM
    accounts
where
	name NOT IN ('Walmart','Target','Nordstrom');

/*Use the web_events table to find all information regarding individuals who were contacted via any method except using organic or adwords methods.*/
SELECT
  *
FROM
  web_events
where
  channel NOT IN ('organic','adwords')

/*All the companies whose names do not start with 'C'.*/
SELECT
	*
FROM
	accounts
WHERE
	name NOT LIKE 'C%'


/*Write a query that returns all the orders where the standard_qty is over 1000, the poster_qty is 0, and the gloss_qty is 0*/
SELECT
	*
FROM
	orders
WHERE
	standard_qty >1000
	AND poster_qty=0
	AND gloss_qty=0;

/*Using the accounts table find all the companies whose names do not start with 'C' and end with 's'.*/
SELECT
	*
FROM
	accounts
WHERE
	name not like 'C%'
    AND name like '%s'
