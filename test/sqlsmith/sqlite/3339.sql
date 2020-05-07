select  
  ref_1.name as c0
from 
  main.t0 as ref_0
    inner join main.t0 as ref_1
    on ((ref_1.id is not NULL) 
        and (0))
where ref_1.name is NULL;
