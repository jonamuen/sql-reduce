select  
  ref_0.name as c0, 
  (select id from main.t0 limit 1 offset 1)
     as c1
from 
  main.t0 as ref_0
where (ref_0.id is NULL) 
  and (case when 0 then ref_0.name else ref_0.name end
       is not NULL)
limit 108;
