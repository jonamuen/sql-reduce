select  
  (select id from main.t0 limit 1 offset 17)
     as c0, 
  ref_0.id as c1
from 
  main.t0 as ref_0
where ref_0.id is not NULL
limit 146;
