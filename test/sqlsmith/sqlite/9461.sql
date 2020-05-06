select  
  subq_0.c0 as c0, 
  subq_0.c0 as c1, 
  subq_0.c1 as c2
from 
  (select  
        ref_0.id as c0, 
        ref_1.name as c1, 
        2 as c2
      from 
        main.t0 as ref_0
          inner join main.t0 as ref_1
          on (ref_1.name is NULL)
      where (1) 
        and (1)
      limit 63) as subq_0
where (0) 
  and (subq_0.c1 is not NULL)
limit 118;
