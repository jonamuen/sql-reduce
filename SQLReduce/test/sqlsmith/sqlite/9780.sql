select  
  (select id from main.t0 limit 1 offset 6)
     as c0, 
  ref_0.id as c1
from 
  main.t0 as ref_0
where case when ((ref_0.id is not NULL) 
        or ((0) 
          and ((1) 
            or (ref_0.id is NULL)))) 
      or ((ref_0.name is NULL) 
        and (ref_0.name is not NULL)) then ref_0.id else ref_0.id end
     is not NULL
limit 139;
