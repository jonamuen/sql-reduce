select  
  subq_0.c4 as c0, 
  subq_0.c2 as c1, 
  subq_0.c2 as c2, 
  case when EXISTS (
      select  
          subq_0.c6 as c0
        from 
          main.t0 as ref_1
            left join main.t0 as ref_2
            on (((0) 
                  and (0)) 
                or ((0) 
                  or (0)))
        where EXISTS (
          select  
              subq_0.c1 as c0, 
              subq_0.c3 as c1, 
              subq_0.c2 as c2
            from 
              main.t0 as ref_3
            where EXISTS (
              select  
                  ref_3.id as c0, 
                  ref_4.name as c1, 
                  subq_0.c3 as c2, 
                  subq_0.c2 as c3, 
                  ref_2.id as c4, 
                  subq_0.c2 as c5, 
                  ref_1.name as c6, 
                  ref_4.name as c7, 
                  ref_4.id as c8, 
                  subq_0.c6 as c9, 
                  ref_1.name as c10, 
                  ref_1.name as c11, 
                  ref_1.id as c12, 
                  subq_0.c0 as c13
                from 
                  main.t0 as ref_4
                where ((subq_0.c6 is NULL) 
                    and (0)) 
                  and (0)
                limit 156)
            limit 118)) then subq_0.c3 else subq_0.c3 end
     as c3, 
  (select id from main.t0 limit 1 offset 2)
     as c4, 
  subq_0.c5 as c5, 
  subq_0.c1 as c6, 
  subq_0.c0 as c7
from 
  (select  
        ref_0.name as c0, 
        ref_0.id as c1, 
        ref_0.id as c2, 
        ref_0.name as c3, 
        ref_0.name as c4, 
        ref_0.id as c5, 
        ref_0.name as c6
      from 
        main.t0 as ref_0
      where (1) 
        or ((ref_0.id is not NULL) 
          or (ref_0.id is NULL))
      limit 21) as subq_0
where 19 is NULL;
