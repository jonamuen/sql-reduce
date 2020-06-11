select  
  subq_0.c1 as c0, 
  (select name from main.t0 limit 1 offset 6)
     as c1, 
  subq_0.c0 as c2, 
  subq_0.c1 as c3, 
  (select name from main.t0 limit 1 offset 3)
     as c4, 
  subq_0.c0 as c5, 
  subq_0.c0 as c6, 
  subq_0.c0 as c7, 
  case when subq_0.c0 is not NULL then (select name from main.t0 limit 1 offset 5)
       else (select name from main.t0 limit 1 offset 5)
       end
     as c8
from 
  (select  
        ref_0.id as c0, 
        ref_0.name as c1
      from 
        main.t0 as ref_0
      where EXISTS (
        select  
            ref_1.name as c0, 
            ref_1.name as c1, 
            ref_1.id as c2
          from 
            main.t0 as ref_1
          where ref_0.name is not NULL
          limit 87)) as subq_0
where (0) 
  or (EXISTS (
    select  
        ref_2.id as c0, 
        subq_0.c1 as c1, 
        subq_0.c0 as c2, 
        subq_0.c0 as c3, 
        subq_0.c1 as c4, 
        subq_0.c0 as c5, 
        ref_2.name as c6
      from 
        main.t0 as ref_2
      where 0
      limit 188));
