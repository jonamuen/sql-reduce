select  
  ref_0.id as c0
from 
  main.t0 as ref_0
    inner join main.t0 as ref_1
    on (ref_1.name is NULL)
where ref_1.id is not NULL
limit 98;
