select  
  ref_0.name as c0, 
  ref_0.name as c1, 
  ref_0.id as c2, 
  ref_0.id as c3
from 
  main.t0 as ref_0
where (0) 
  and ((ref_0.name is not NULL) 
    and ((((0) 
          or ((0) 
            and ((select id from main.t0 limit 1 offset 3)
                 is NULL))) 
        or (((1) 
            or (3 is NULL)) 
          and (((select id from main.t0 limit 1 offset 6)
                 is not NULL) 
            or (1)))) 
      or (0)))
limit 82;
