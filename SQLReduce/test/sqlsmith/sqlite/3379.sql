select  
  ref_0.name as c0
from 
  main.t0 as ref_0
where (select name from main.t0 limit 1 offset 42)
     is NULL;
