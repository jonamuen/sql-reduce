select  
  (select name from main.t0 limit 1 offset 3)
     as c0, 
  ref_1.id as c1, 
  ref_0.id as c2, 
  (select id from main.t0 limit 1 offset 6)
     as c3
from 
  main.t0 as ref_0
    left join main.t0 as ref_1
    on (ref_0.id = ref_1.id )
where ref_0.id is NULL
limit 143;
