select  
  ref_0.id as c0
from 
  main.t0 as ref_0
    left join main.t0 as ref_1
    on (ref_1.id is NULL)
where ref_0.name is NULL
limit 46;
