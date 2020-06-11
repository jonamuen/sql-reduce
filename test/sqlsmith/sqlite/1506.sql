select  
  (select id from main.t0 limit 1 offset 6)
     as c0
from 
  main.t0 as ref_0
where ref_0.name is not NULL
limit 57;
