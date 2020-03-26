select  
  subq_0.c6 as c0
from 
  (select  
        ref_0.id as c0, 
        79 as c1, 
        ref_0.id as c2, 
        ref_0.name as c3, 
        ref_0.id as c4, 
        ref_0.name as c5, 
        ref_0.id as c6, 
        ref_0.id as c7, 
        case when ((ref_0.id is NULL) 
              and (ref_0.id is not NULL)) 
            and (1) then ref_0.name else ref_0.name end
           as c8
      from 
        main.t0 as ref_0
      where EXISTS (
        select  
            ref_1.id as c0, 
            ref_0.name as c1, 
            ref_0.id as c2, 
            ref_1.name as c3, 
            ref_1.name as c4, 
            ref_0.name as c5, 
            ref_0.id as c6, 
            ref_0.name as c7, 
            ref_0.id as c8
          from 
            main.t0 as ref_1
          where 1
          limit 176)
      limit 76) as subq_0
where subq_0.c4 is not NULL
limit 145;
