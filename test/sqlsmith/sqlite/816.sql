select  
  ref_1.name as c0
from 
  main.t0 as ref_0
    inner join main.t0 as ref_1
    on ((ref_0.id is NULL) 
        or (ref_0.name is NULL))
where ref_0.name is not NULL
limit 89;
