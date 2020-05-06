select  
  ref_0.id as c0
from 
  main.t0 as ref_0
where (select name from main.t0 limit 1 offset 5)
     is NULL
limit 149;
