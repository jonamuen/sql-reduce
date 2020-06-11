select  
  subq_0.c0 as c0
from 
  (select  
        (select id from main.t0 limit 1 offset 4)
           as c0
      from 
        main.t0 as ref_0
      where 1
      limit 114) as subq_0
where (subq_0.c0 is not NULL) 
  and (EXISTS (
    select  
        subq_0.c0 as c0, 
        ref_1.id as c1, 
        case when (1) 
            and (1) then ref_1.id else ref_1.id end
           as c2, 
        (select name from main.t0 limit 1 offset 4)
           as c3, 
        (select name from main.t0 limit 1 offset 1)
           as c4, 
        subq_0.c0 as c5, 
        ref_1.id as c6
      from 
        main.t0 as ref_1
      where (subq_0.c0 is NULL) 
        and (((EXISTS (
              select  
                  subq_0.c0 as c0, 
                  ref_1.id as c1, 
                  ref_1.name as c2, 
                  ref_1.name as c3, 
                  ref_1.name as c4, 
                  ref_2.name as c5, 
                  18 as c6, 
                  ref_2.name as c7, 
                  (select name from main.t0 limit 1 offset 94)
                     as c8, 
                  ref_2.name as c9, 
                  ref_2.name as c10, 
                  ref_2.id as c11, 
                  ref_1.id as c12, 
                  ref_2.id as c13, 
                  subq_0.c0 as c14, 
                  subq_0.c0 as c15, 
                  ref_1.name as c16, 
                  ref_2.id as c17, 
                  subq_0.c0 as c18, 
                  subq_0.c0 as c19, 
                  subq_0.c0 as c20, 
                  subq_0.c0 as c21, 
                  ref_1.id as c22
                from 
                  main.t0 as ref_2
                where 0
                limit 121)) 
            or (1)) 
          and (ref_1.id is NULL))));
