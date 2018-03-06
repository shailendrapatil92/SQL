SELECT name||'('||SUBSTR(occupation,1,1)||')'
FROM occupations
ORDER BY name;
SELECT 'There are total '||COUNT(occupation)||' '||LOWER(occupation)||'s.'
FROM occupations
GROUP BY occupation
ORDER BY COUNT(occupation),occupation;