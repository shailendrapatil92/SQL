SELECT RPAD('*',LEVEL*2,' *') "STARS"
FROM dual
CONNECT BY LEVEL <=20
ORDER BY STARS DESC;