select  
  (select name from main.t0 limit 1 offset 3)
     as c0
from 
  main.t0 as ref_0
where 0
limit 63;
