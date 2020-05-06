select  
  35 as c0, 
  ref_0.name as c1, 
  ref_0.name as c2, 
  ref_0.name as c3, 
  (select id from main.t0 limit 1 offset 1)
     as c4, 
  ref_0.name as c5
from 
  main.t0 as ref_0
where (case when 1 then ref_0.id else ref_0.id end
       is not NULL) 
  or (0)
limit 118;
