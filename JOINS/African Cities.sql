SELECT CT.NAME 
FROM CITY CT, COUNTRY CO
WHERE CT.COUNTRYCODE=CO.CODE
AND CO.CONTINENT='Africa';