select  
  ref_0.id as c0
from 
  main.t0 as ref_0
where ((((ref_0.name is not NULL) 
        and ((1) 
          or ((0) 
            and (ref_0.id is NULL)))) 
      and (ref_0.id is NULL)) 
    or (1)) 
  and ((ref_0.name is NULL) 
    or (ref_0.name is not NULL))
limit 150;
