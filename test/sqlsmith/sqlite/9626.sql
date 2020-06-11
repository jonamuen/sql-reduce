select  
  subq_0.c4 as c0, 
  subq_0.c1 as c1
from 
  (select  
        ref_1.id as c0, 
        ref_0.id as c1, 
        ref_1.name as c2, 
        ref_1.id as c3, 
        ref_1.id as c4, 
        ref_1.name as c5, 
        ref_1.id as c6, 
        ref_1.name as c7, 
        ref_0.name as c8, 
        ref_0.name as c9, 
        ref_1.name as c10, 
        ref_1.name as c11
      from 
        main.t0 as ref_0
          left join main.t0 as ref_1
          on (1)
      where ((ref_0.name is NULL) 
          and (0)) 
        and ((ref_0.id is not NULL) 
          or ((ref_0.id is not NULL) 
            or ((1) 
              or (ref_0.name is NULL))))) as subq_0
where 0
limit 157;
