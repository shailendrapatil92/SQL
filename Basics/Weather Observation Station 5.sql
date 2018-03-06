SELECT * FROM
   (SELECT city, length(city)
    FROM station
    ORDER BY length(city) asc, city)
WHERE rownum = 1;
SELECT * FROM
   (SELECT city, length(city)
    FROM station
    ORDER BY length(city) desc, city)
WHERE rownum = 1;