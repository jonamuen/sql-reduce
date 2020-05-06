select  
  (select name from main.t0 limit 1 offset 3)
     as c0
from 
  main.t0 as ref_0
where ref_0.name is not NULL
limit 140;
