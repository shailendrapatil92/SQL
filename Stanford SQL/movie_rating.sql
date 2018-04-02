--1 Find the title of all movies directed by Steven Spielberg

select 
	title
from
	movie
where
	director='Steven Spielberg'
	
--2 Find all years that have a movie that received a rating of 4 or 5, and sort them in increasing order. 
select 
	distinct mo.year
from 
	rating r
JOIN
	movie mo
on
	mo.mid=r.mid
where 
	stars in (4,5)
order by 
	mo.year

--3 Find the titles of all movies that have no ratings. 
select
	title
from 
	movie
where
	mid not in (select mid from rating)

--4 Some reviewers didn't provide a date with their rating. 
--Find the names of all reviewers who have ratings with a NULL value for the date. 
select
	re.name
from 
	reviewer re
JOIN
	rating ra
on 
	ra.rid=re.rid
where
	ra.ratingDate is null
	
--5 Write a query to return the ratings data in a more readable format: reviewer name, movie title, stars, 
--and ratingDate. Also, sort the data, first by reviewer name, then by movie title, and lastly by 
--number of stars.
select
	re.name as reviewer_name,m.title as movie_name,ra.stars,ra.ratingDate
from 
	rating ra
JOIN 
	reviewer re
ON 
	ra.rid= re.rid
JOIN
	movie m
ON 
	m.mid=ra.mid
Order by
	re.name,m.title,ra.stars
	
--6 For all cases where the same reviewer rated the same movie twice and 
--gave it a higher rating the second time, return the reviewer's name and the title of the movie. 

select 
	re.name,m.title
from 
	rating r1
JOIN
	rating r2
on 
	r1.rid=r2.rid 
JOIN
	reviewer re
on re.rid=r1.rid
JOIN
	movie m
on
	m.mid=r1.mid
where
	r1.mid=r2.mid and
	r1.stars<>r2.stars and
	r1.ratingDate<r2.ratingDate and
	r1.stars<r2.stars
	
--7 For each movie that has at least one rating, find the highest number of stars that movie received. 
--Return the movie title and number of stars. Sort by movie title.

select 
	m.title,max(stars)
from 
	rating ra
JOIN
	movie m
on
	m.mid=ra.mid
where 
	stars>=1
group by
	m.title
order by
	m.title
	
	
--8 For each movie, return the title and the 'rating spread', that is, the difference 
--between highest and lowest ratings given to that movie. Sort by rating spread from highest to lowest, 
--then by movie title. 



select 
	m.title,MAX(ra.stars)-MIN(ra.stars)
from 
	rating ra
JOIN
	movie m
on
	m.mid=ra.mid
Group by
	m.title
Order by MAX(ra.stars)-MIN(ra.stars) desc,m.title

--9 Find the difference between the average rating of movies released before 1980 
--and the average rating of movies released after 1980. (Make sure to calculate the average 
--rating for each movie, then the average of those averages for movies before 1980 and movies after. 
--Don't just calculate the overall average rating before and after 1980.) 
select 
	round(avg(ra.stars),2)
from 
	rating ra
JOIN
	movie m
on 
	m.mid=ra.mid

select 
	avg(beforedate.avg_rating)-avg(afterdate.avg_rating) 
from 
	(select m.year,avg(ra.stars) as avg_rating from rating ra JOIN movie m on 
	m.mid=ra.mid Group by m.year Having m.year<1980) as beforedate,
	(select m.year,avg(ra.stars) as avg_rating from rating ra JOIN movie m on 
	m.mid=ra.mid Group by m.year Having m.year>1980) as afterdate
	

--Extras

--1 Find the names of all reviewers who rated Gone with the Wind. 
select 
	name
from
	reviewer
where 
	rid in (
	select 
		ra.rid 
	from 
		movie m
	JOIN
		rating ra
	on
		ra.mid=m.mid
	where
		m.title='Gone with the Wind')
		

--2 For any rating where the reviewer is the same as the director of the movie, 
--return the reviewer name, movie title, and number of stars. 
select 
	re.name,m.title,ra.stars
from 
	rating ra,
	movie m,
	reviewer re
where
	ra.rid=re.rid and
	ra.mid = m.mid and
	m.director=re.name
	
	
--3 Return all reviewer names and movie names together in a single list, alphabetized. 
--(Sorting by the first name of the reviewer and first word in the title is fine; no need for 
--special processing on last names or removing "The".) 
select 
	title as name
from 
	movie
UNION
select
	name
from 
	reviewer
order by 
	split_part(name,' ',1)
		

--4 Find the titles of all movies not reviewed by Chris Jackson. 
select 
	title 
from 
	movie
where
	mid not in (
	select 
		ra.mid
	from 
		rating ra
	JOIN
		reviewer re
	on 
		re.rid=ra.rid
	where 
		re.name='Chris Jackson')

--5 For all pairs of reviewers such that both reviewers gave a rating to the same movie, 
--return the names of both reviewers. Eliminate duplicates, don't pair reviewers with themselves,
--and include each pair only once. For each pair, return the names in the pair in alphabetical order. 

select 
	distinct re1.name, re2.name
from
	rating ra1
JOIN
	rating ra2
on
	ra1.mid=ra2.mid
JOIN
	reviewer re1
on 
	re1.rid=ra1.rid
JOIN
	reviewer re2
on
	re2.rid=ra2.rid
where
	re1.name<re2.name
Order by
	re1.name,re2.name


--6 For each rating that is the lowest (fewest stars) currently in the database, 
--return the reviewer name, movie title, and number of stars. 
select 
	re.name,m.title,ra.stars
from 
	rating ra
JOIN
	movie m
ON
	ra.mid=m.mid
JOIN
	reviewer re
on
	re.rid=ra.rid
where
	ra.stars in (select 
	min(stars)
from 
	rating )

--7 List movie titles and average ratings, from highest-rated to lowest-rated. 
--If two or more movies have the same average rating, list them in alphabetical order. 
select
	m.title,
from 
	rating ra
JOIN
	movie m
on
	ra.mid=m.mid
GROUP by
	m.title
ORDER by 
	avg(ra.stars) desc,m.title

--8 Find the names of all reviewers who have contributed three or more ratings. 
select 
	re.name,count(re.rid)
from 
	reviewer re
JOIN
	rating ra
on
	ra.rid=re.rid
Group by
	re.name
having
	count(re.rid)>=3
	
	
--9 Some directors directed more than one movie. For all such directors, return the titles 
--of all movies directed by them, along with the director name. Sort by director name, then movie title.

select 
	title,director 
from
	movie
where
	director in (
	select 
		director
	from 
		movie
	Group by 
		director
	having count(*)>1)
Order by director,title

--10 Find the movie(s) with the highest average rating. Return the movie title(s) and average rating. 
--(Hint: This query is more difficult to write in SQLite than other systems; you might think of it as 
--finding the highest average rating and then choosing the movie(s) with that average rating.) 

--This wont work in sql lite
select 
	highest.title,highest.average
from
(select 
	m.title,avg(stars) as average,rank() OVER(order by avg(stars) desc) as rank_high
from 
	rating ra
Join
	movie m
on
	m.mid=ra.mid
Group by
	m.title) as highest
where
	highest.rank_high=1

--for sqllite
select 
	m.title,avg(stars) as average
from 
	rating ra
Join
	movie m
on
	m.mid=ra.mid
Group by
	m.title
having 
	avg(stars) in (
select max(min_average.average) from (
select 
	m.title,avg(stars) as average
from 
	rating ra
Join
	movie m
on
	m.mid=ra.mid
Group by
	m.title
ORDER BY 
	avg(stars)) as min_average)

--11 Find the movie(s) with the lowest average rating. Return the movie title(s) and average rating.
select 
	m.title,avg(stars) as average
from 
	rating ra
Join
	movie m
on
	m.mid=ra.mid
Group by
	m.title
having 
	avg(stars) in (
select min(min_average.average) from (
select 
	m.title,avg(stars) as average
from 
	rating ra
Join
	movie m
on
	m.mid=ra.mid
Group by
	m.title
ORDER BY 
	avg(stars)) as min_average)
	
--12 For each director, return the director's name together with the title(s) of the movie(s) they 
--directed that received the highest rating among all of their movies, and the value of that rating. 
--Ignore movies whose director is NULL. 







select 
 distinct highest_star.director,highest_star.title,highest_star.stars
from
(
select 
	m.director,m.title,stars,rank() OVER(PARTITION BY m.director order by stars desc)
from
	rating ra
JOIN
	movie m
on
	m.mid =ra.mid
where
	m.director is not null) as highest_star
where
	highest_star.rank=1









