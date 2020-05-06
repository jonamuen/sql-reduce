select  
  ref_1.name as c0, 
  subq_0.c0 as c1, 
  ref_1.name as c2, 
  ref_1.name as c3, 
  subq_0.c1 as c4
from 
  (select  
          (select name from main.t0 limit 1 offset 5)
             as c0, 
          ref_0.name as c1
        from 
          main.t0 as ref_0
        where ref_0.id is not NULL) as subq_0
    inner join main.t0 as ref_1
    on (subq_0.c1 = ref_1.name )
where 1
limit 87;
