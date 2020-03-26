select  
  cast(coalesce(subq_0.c0,
    cast(coalesce(subq_0.c0,
      subq_0.c0) as INT)) as INT) as c0, 
  subq_0.c0 as c1, 
  subq_0.c0 as c2
from 
  (select  
        ref_0.id as c0
      from 
        main.t0 as ref_0
      where ref_0.id is not NULL) as subq_0
where EXISTS (
  select  
      subq_1.c0 as c0, 
      subq_0.c0 as c1, 
      subq_0.c0 as c2, 
      subq_1.c0 as c3, 
      subq_0.c0 as c4, 
      subq_1.c0 as c5
    from 
      (select  
            69 as c0
          from 
            main.t0 as ref_1
          where (EXISTS (
              select  
                  75 as c0, 
                  32 as c1, 
                  subq_0.c0 as c2, 
                  subq_0.c0 as c3, 
                  (select id from main.t0 limit 1 offset 6)
                     as c4, 
                  ref_2.id as c5, 
                  93 as c6, 
                  ref_1.name as c7, 
                  ref_2.name as c8, 
                  (select id from main.t0 limit 1 offset 6)
                     as c9, 
                  ref_1.id as c10, 
                  ref_2.id as c11, 
                  ref_1.name as c12, 
                  ref_1.name as c13, 
                  ref_2.id as c14, 
                  ref_1.name as c15, 
                  (select id from main.t0 limit 1 offset 2)
                     as c16, 
                  ref_1.id as c17, 
                  subq_0.c0 as c18, 
                  ref_2.id as c19
                from 
                  main.t0 as ref_2
                where (1) 
                  and (ref_1.name is not NULL))) 
            and (1)) as subq_1
    where (1) 
      and ((EXISTS (
          select  
              subq_0.c0 as c0, 
              (select name from main.t0 limit 1 offset 3)
                 as c1, 
              subq_0.c0 as c2, 
              subq_0.c0 as c3, 
              subq_0.c0 as c4
            from 
              main.t0 as ref_3
            where ref_3.id is NULL
            limit 81)) 
        or ((select name from main.t0 limit 1 offset 3)
             is NULL))
    limit 121)
limit 95;
