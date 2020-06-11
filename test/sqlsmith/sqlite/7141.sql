select  
  ref_0.id as c0
from 
  main.t0 as ref_0
where ((1) 
    and (0)) 
  and ((select name from main.t0 limit 1 offset 2)
       is NULL)
limit 119;
