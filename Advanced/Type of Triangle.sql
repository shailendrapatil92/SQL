select
case 
    when (a + b) <= c or (b + c) <= a or (a + c) <= b then 'Not A Triangle' 
    when (a = b and b!=c and a!=c)  or (a!=b and b = c and a!=c) or (a!=b and b!=c and c = a) then 'Isosceles' 
    when a = b and b = c then 'Equilateral'  
    else 'Scalene'
end 
from triangles;