select  
  subq_0.c8 as c0, 
  subq_0.c1 as c1, 
  subq_0.c6 as c2, 
  subq_0.c4 as c3, 
  subq_0.c1 as c4, 
  subq_0.c0 as c5, 
  subq_0.c2 as c6
from 
  (select  
        ref_0.name as c0, 
        ref_0.name as c1, 
        ref_0.id as c2, 
        (select id from main.t0 limit 1 offset 1)
           as c3, 
        ref_0.id as c4, 
        ref_0.id as c5, 
        (select name from main.t0 limit 1 offset 3)
           as c6, 
        ref_0.name as c7, 
        ref_0.id as c8
      from 
        main.t0 as ref_0
      where ref_0.name is NULL
      limit 137) as subq_0
where ((EXISTS (
      select  
          ref_1.id as c0, 
          subq_0.c4 as c1, 
          subq_0.c4 as c2, 
          subq_0.c4 as c3, 
          subq_0.c5 as c4, 
          subq_0.c0 as c5, 
          subq_0.c5 as c6, 
          ref_1.id as c7, 
          14 as c8, 
          ref_1.name as c9, 
          63 as c10, 
          ref_1.name as c11, 
          ref_2.id as c12, 
          subq_0.c1 as c13
        from 
          main.t0 as ref_1
            inner join main.t0 as ref_2
            on (1)
        where (1) 
          and ((59 is not NULL) 
            and ((0) 
              and (ref_2.id is NULL))))) 
    or (((((0) 
            and (subq_0.c1 is not NULL)) 
          and (subq_0.c7 is NULL)) 
        or (0)) 
      or (0))) 
  and (1)
limit 98;
