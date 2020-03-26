select  
  subq_0.c7 as c0, 
  subq_0.c0 as c1, 
  subq_0.c15 as c2
from 
  (select  
        ref_0.id as c0, 
        ref_0.name as c1, 
        ref_0.id as c2, 
        ref_0.id as c3, 
        ref_0.name as c4, 
        ref_0.id as c5, 
        ref_0.id as c6, 
        ref_0.id as c7, 
        ref_0.id as c8, 
        ref_0.id as c9, 
        case when ref_0.name is NULL then ref_0.name else ref_0.name end
           as c10, 
        ref_0.id as c11, 
        ref_0.id as c12, 
        ref_0.id as c13, 
        case when EXISTS (
            select  
                ref_0.name as c0, 
                39 as c1
              from 
                main.t0 as ref_1
              where (ref_1.name is NULL) 
                or (1)
              limit 153) then 75 else 75 end
           as c14, 
        (select name from main.t0 limit 1 offset 5)
           as c15, 
        ref_0.id as c16
      from 
        main.t0 as ref_0
      where (1) 
        and (ref_0.name is not NULL)) as subq_0
where 1;
