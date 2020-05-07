select  
  subq_0.c7 as c0, 
  subq_0.c0 as c1, 
  subq_0.c2 as c2, 
  subq_0.c4 as c3, 
  subq_0.c5 as c4, 
  subq_0.c1 as c5, 
  subq_0.c3 as c6, 
  subq_0.c2 as c7, 
  subq_0.c2 as c8, 
  subq_0.c4 as c9
from 
  (select  
        ref_0.id as c0, 
        ref_0.id as c1, 
        ref_0.id as c2, 
        ref_0.id as c3, 
        ref_0.name as c4, 
        ref_0.name as c5, 
        (select id from main.t0 limit 1 offset 85)
           as c6, 
        ref_0.name as c7, 
        ref_0.id as c8
      from 
        main.t0 as ref_0
      where ((ref_0.id is NULL) 
          or (((select name from main.t0 limit 1 offset 5)
                 is NULL) 
            and (EXISTS (
              select  
                  ref_1.id as c0, 
                  ref_1.name as c1, 
                  ref_0.id as c2, 
                  ref_0.id as c3, 
                  ref_1.id as c4, 
                  ref_1.name as c5, 
                  ref_0.id as c6, 
                  (select id from main.t0 limit 1 offset 87)
                     as c7, 
                  ref_0.name as c8, 
                  ref_0.id as c9, 
                  ref_0.id as c10
                from 
                  main.t0 as ref_1
                where ref_0.id is not NULL)))) 
        or (ref_0.id is NULL)
      limit 109) as subq_0
where ((1) 
    or ((subq_0.c1 is NULL) 
      or (EXISTS (
        select  
            ref_2.name as c0
          from 
            main.t0 as ref_2
          where (ref_2.name is not NULL) 
            and ((((((1) 
                      or (((0) 
                          and (ref_2.id is NULL)) 
                        and (((select name from main.t0 limit 1 offset 19)
                               is NULL) 
                          or (0)))) 
                    and (subq_0.c6 is NULL)) 
                  and ((0) 
                    or ((select id from main.t0 limit 1 offset 5)
                         is NULL))) 
                or (0)) 
              and (0))
          limit 136)))) 
  or ((1) 
    or (subq_0.c3 is NULL));
