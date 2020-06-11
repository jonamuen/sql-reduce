select  
  ref_0.id as c0, 
  ref_0.name as c1
from 
  main.t0 as ref_0
    left join main.t0 as ref_1
    on ((((ref_1.name is NULL) 
            and (74 is not NULL)) 
          and (1)) 
        and (0))
where ref_0.name is NULL
limit 107;
