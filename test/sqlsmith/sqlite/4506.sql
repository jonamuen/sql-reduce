select  
  ref_0.id as c0
from 
  main.t0 as ref_0
where ((ref_0.id is not NULL) 
    and (case when (((ref_0.name is not NULL) 
              or (1)) 
            and (ref_0.name is not NULL)) 
          and (ref_0.id is not NULL) then cast(coalesce(ref_0.id,
          ref_0.id) as INT) else cast(coalesce(ref_0.id,
          ref_0.id) as INT) end
         is NULL)) 
  and ((1) 
    or (ref_0.name is NULL))
limit 48;
