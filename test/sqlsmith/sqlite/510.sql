select  
  ref_0.name as c0, 
  ref_0.name as c1, 
  ref_0.id as c2, 
  ref_0.id as c3
from 
  main.t0 as ref_0
where (((((1) 
          or (1)) 
        or (ref_0.name is not NULL)) 
      and (case when 1 then ref_0.name else ref_0.name end
           is not NULL)) 
    and (ref_0.id is not NULL)) 
  and (ref_0.name is not NULL)
limit 66;
