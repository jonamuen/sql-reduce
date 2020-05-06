select  
  case when 1 then (select id from main.t0 limit 1 offset 13)
       else (select id from main.t0 limit 1 offset 13)
       end
     as c0, 
  subq_0.c1 as c1
from 
  (select  
        ref_0.name as c0, 
        ref_0.name as c1, 
        ref_0.name as c2, 
        ref_0.name as c3
      from 
        main.t0 as ref_0
      where 79 is not NULL
      limit 96) as subq_0
where ((0) 
    and (subq_0.c2 is not NULL)) 
  and (EXISTS (
    select  
        subq_0.c1 as c0, 
        subq_1.c3 as c1, 
        subq_1.c1 as c2, 
        subq_1.c3 as c3, 
        subq_1.c0 as c4, 
        subq_1.c3 as c5, 
        subq_0.c0 as c6, 
        subq_1.c2 as c7, 
        (select id from main.t0 limit 1 offset 47)
           as c8, 
        subq_0.c2 as c9, 
        77 as c10, 
        subq_1.c0 as c11, 
        (select id from main.t0 limit 1 offset 2)
           as c12, 
        (select name from main.t0 limit 1 offset 30)
           as c13, 
        91 as c14
      from 
        (select  
              subq_0.c1 as c0, 
              ref_1.id as c1, 
              ref_1.name as c2, 
              subq_0.c3 as c3
            from 
              main.t0 as ref_1
            where (ref_1.name is NULL) 
              and (1)) as subq_1
      where 80 is not NULL
      limit 58))
limit 27;
