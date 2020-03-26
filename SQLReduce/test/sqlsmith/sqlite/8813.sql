select  
  subq_0.c0 as c0, 
  subq_0.c6 as c1, 
  subq_0.c2 as c2, 
  subq_0.c1 as c3, 
  (select id from main.t0 limit 1 offset 4)
     as c4
from 
  (select  
        (select id from main.t0 limit 1 offset 6)
           as c0, 
        ref_0.name as c1, 
        ref_0.name as c2, 
        cast(nullif(ref_0.name,
          ref_0.name) as VARCHAR(16)) as c3, 
        ref_0.id as c4, 
        ref_0.id as c5, 
        ref_0.id as c6, 
        ref_0.id as c7, 
        ref_0.name as c8, 
        ref_0.id as c9, 
        ref_0.name as c10, 
        ref_0.name as c11, 
        ref_0.id as c12, 
        ref_0.id as c13, 
        ref_0.name as c14, 
        (select id from main.t0 limit 1 offset 5)
           as c15, 
        ref_0.id as c16, 
        ref_0.id as c17, 
        ref_0.id as c18
      from 
        main.t0 as ref_0
      where 1
      limit 99) as subq_0
where EXISTS (
  select  
      cast(nullif(subq_0.c18,
        subq_0.c17) as INT) as c0, 
      ref_1.id as c1, 
      36 as c2, 
      ref_1.id as c3, 
      ref_1.id as c4, 
      (select id from main.t0 limit 1 offset 89)
         as c5, 
      ref_1.id as c6, 
      ref_1.name as c7, 
      ref_1.name as c8
    from 
      main.t0 as ref_1
    where ((select name from main.t0 limit 1 offset 1)
           is not NULL) 
      and (((ref_1.name is NULL) 
          and (0)) 
        and ((0) 
          or (subq_0.c18 is not NULL))))
limit 105;
