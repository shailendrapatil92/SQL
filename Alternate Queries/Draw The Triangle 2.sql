select rpad( '* ', level*2, '* ' )
from dual
CONNECT BY level<= 20;