select  
  subq_0.c0 as c0, 
  subq_0.c6 as c1
from 
  (select  
        ref_0.id as c0, 
        ref_0.id as c1, 
        ref_0.name as c2, 
        ref_0.id as c3, 
        ref_0.id as c4, 
        ref_0.id as c5, 
        ref_0.name as c6
      from 
        main.t0 as ref_0
      where EXISTS (
        select  
            ref_0.id as c0, 
            ref_1.id as c1, 
            ref_0.name as c2, 
            ref_2.name as c3, 
            ref_0.id as c4
          from 
            main.t0 as ref_1
              inner join main.t0 as ref_2
              on ((ref_0.name is not NULL) 
                  and (ref_0.name is not NULL))
          where ref_1.id is NULL
          limit 87)) as subq_0
where 1;
