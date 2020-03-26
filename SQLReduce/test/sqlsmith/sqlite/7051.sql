select  
  ref_1.id as c0, 
  ref_0.name as c1, 
  ref_1.name as c2
from 
  main.t0 as ref_0
    left join main.t0 as ref_1
    on (0)
where ref_0.name is not NULL
limit 78;
