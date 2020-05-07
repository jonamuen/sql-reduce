select  
  ref_0.name as c0, 
  ref_0.name as c1, 
  ref_0.id as c2, 
  ref_0.id as c3
from 
  main.t0 as ref_0
where (ref_0.name is NULL) 
  or ((ref_0.id is not NULL) 
    and ((((ref_0.name is NULL) 
          or (ref_0.id is not NULL)) 
        or ((0) 
          and (ref_0.id is not NULL))) 
      or ((((ref_0.name is NULL) 
            and (0)) 
          or ((ref_0.name is NULL) 
            and ((0) 
              or ((ref_0.name is NULL) 
                or (0))))) 
        and (ref_0.id is NULL))))
limit 137;
