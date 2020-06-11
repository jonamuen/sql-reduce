select  
  ref_0.name as c0, 
  ref_0.id as c1
from 
  main.t0 as ref_0
where (((select name from main.t0 limit 1 offset 1)
         is NULL) 
    or (ref_0.id is NULL)) 
  or ((((ref_0.name is NULL) 
        or (((((0) 
                or (1)) 
              and (ref_0.id is NULL)) 
            or (((ref_0.name is NULL) 
                or (ref_0.name is not NULL)) 
              or ((ref_0.id is NULL) 
                or (((0) 
                    or (ref_0.name is NULL)) 
                  or (ref_0.name is NULL))))) 
          or (1))) 
      or ((ref_0.id is NULL) 
        and (cast(coalesce(ref_0.id,
            ref_0.id) as INT) is not NULL))) 
    or (ref_0.name is not NULL))
limit 153;
