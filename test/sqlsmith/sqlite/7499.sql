select  
  subq_0.c7 as c0, 
  subq_0.c8 as c1, 
  subq_0.c8 as c2, 
  subq_0.c9 as c3, 
  (select id from main.t0 limit 1 offset 3)
     as c4
from 
  (select  
        ref_0.id as c0, 
        24 as c1, 
        ref_0.name as c2, 
        ref_0.id as c3, 
        ref_0.name as c4, 
        ref_0.id as c5, 
        (select id from main.t0 limit 1 offset 5)
           as c6, 
        (select id from main.t0 limit 1 offset 6)
           as c7, 
        (select name from main.t0 limit 1 offset 5)
           as c8, 
        ref_0.name as c9, 
        ref_0.id as c10, 
        ref_0.name as c11, 
        87 as c12, 
        ref_0.name as c13, 
        ref_0.name as c14, 
        ref_0.name as c15, 
        ref_0.name as c16, 
        95 as c17, 
        12 as c18, 
        ref_0.name as c19
      from 
        main.t0 as ref_0
      where ref_0.id is NULL) as subq_0
where (0) 
  and (subq_0.c12 is NULL)
limit 20;
