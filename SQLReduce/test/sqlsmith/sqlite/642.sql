select  
  subq_0.c2 as c0, 
  subq_0.c1 as c1, 
  subq_0.c0 as c2, 
  subq_0.c2 as c3, 
  subq_0.c1 as c4, 
  subq_0.c0 as c5, 
  subq_0.c2 as c6
from 
  (select  
        ref_0.id as c0, 
        ref_0.id as c1, 
        ref_0.id as c2
      from 
        main.t0 as ref_0
      where ref_0.name is NULL
      limit 90) as subq_0
where (case when 1 then subq_0.c2 else subq_0.c2 end
       is NULL) 
  and ((1) 
    and (subq_0.c1 is not NULL))
limit 124;
