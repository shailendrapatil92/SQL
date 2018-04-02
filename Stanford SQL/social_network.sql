--1 Find the names of all students who are friends with someone named Gabriel. 

select 
	name
from 
	highschooler
where
	id in (
select 
	f1.id2
from 
	friend f1
where 
	f1.id1 in (
	select 
		id
	from 
		highschooler 
	where 
		name='Gabriel')
UNION
select 
	f2.id1
from 
	friend f2
where 
	f2.id2 in (
	select 
		id
	from 
		highschooler 
	where 
		name='Gabriel'))
		
--2 For every student who likes someone 2 or more grades younger than themselves, return that 
--student's name and grade, and the name and grade of the student they like. 		
select 
	h1.name,h1.grade,h2.name,h2.grade
from 
	likes l1,likes l2,highschooler h1,highschooler h2
where
	l1.id1=h1.id and
	l1.id1=l2.id1 and
	l2.id2=h2.id and
	h1.grade-h2.grade>=2
	
--3 For every pair of students who both like each other, return the name and grade of both students. 
--Include each pair only once, with the two names in alphabetical order. 


select 
	 h1.name,h1.grade,h2.name,h2.grade
from 
	likes l1,likes l2,highschooler h1,highschooler h2
where
	l1.id1 =l2.id2 and
	l1.id2=l2.id1 and
	h1.name<h2.name and
	l1.id1=h1.id and
	l2.id1 =h2.id

--4 Find all students who do not appear in the Likes table (as a student who likes or is liked) and 
--return their names and grades. Sort by grade, then by name within each grade. 

select 
	name,grade
from 
	highschooler
where 
id not in (
	select 
		id1 as ids
	from 
		likes
	UNION
	select 
		id2 as ids
	from 
		likes)
ORDER BY grade,name
		
		
--5 For every situation where student A likes student B, but we have no information about whom B 
--likes (that is, B does not appear as an ID1 in the Likes table), return A and B's names and grades. 

select 
	h1.name,h1.grade,h2.name,h2.grade
from 
	likes l,highschooler h1,highschooler h2
where 
	id2 in (select l1.id2 from likes l1 EXCEPT select l2.id1 from likes l2) and
	id1=h1.id and
	id2=h2.id and
	id1<>id2

--6 Find names and grades of students who only have friends in the same grade. Return the result 
--sorted by grade, then by name within each grade. 

select 
	name,grade
from
	highschooler 
where 
	id in (
(select 
	id1 as ids
from 
	friend
UNION
select 
	id2 as ids
from friend)
EXCEPT
(select 
	id1 as ids
from 
	friend,highschooler h1, highschooler h2
where
	h1.id=id1 and
	h2.id =id2 and
	h1.grade<>h2.grade
UNION
select 
	id2 as ids
from 
	friend,highschooler h1, highschooler h2
where
	h1.id=id1 and
	h2.id =id2 and
	h1.grade<>h2.grade))
ORDER by grade,name




select h.name, h.grade
from 
(select 
	id1 as ids
from 
	friend
UNION
select 
	id2 as ids
from friend) as all_friend,highschooler h
where 
h.id=ids and
ids not in 
(select 
	id1 as ids
from 
	friend,highschooler h1, highschooler h2
where
	h1.id=id1 and
	h2.id =id2 and
	h1.grade<>h2.grade
UNION
select 
	id2 as ids
from 
	friend,highschooler h1, highschooler h2
where
	h1.id=id1 and
	h2.id =id2 and
	h1.grade<>h2.grade)
ORDER BY
	h.grade,h.name
	

--7 For each student A who likes a student B where the two are not friends, find if they have a friend C 
--in common (who can introduce them!). For all such trios, return the name and grade of A, B, and C

select 
	h1.name,h1.grade,h2.name,h2.grade,h3.name,h3.grade
from 
	likes l1,
	highschooler h1,
	highschooler h2,
	friend f1,
	friend f2,
	highschooler h3
where
	h1.id = l1.id1 and
	h2.id = l1.id2 and
	h2.id not in (select id2 from friend where id1=h1.id) and
	l1.id1 = f1.id1 and 
	h3.id=f1.id2 and
	h3.id = f2.id1 and
	f2.id2 =l1.id2





--8 Find the difference between the number of students in the school and the number of different first names. 
select 
	count(id) - count(distinct name)
from 
	highschooler

--9 Find the name and grade of all students who are liked by more than one other student.  
select 
	h.name,h.grade
from
	highschooler h
where
	h.id in (
select 
	id2
from 
	likes
group by
	id2
having count(*)>1)






