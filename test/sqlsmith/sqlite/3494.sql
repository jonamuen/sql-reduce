select  
  ref_0.id as c0
from 
  main.t0 as ref_0
where (select id from main.t0 limit 1 offset 6)
     is not NULL
limit 74;
