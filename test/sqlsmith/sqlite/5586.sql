select  
  60 as c0, 
  subq_0.c5 as c1, 
  subq_0.c4 as c2
from 
  (select  
        ref_0.name as c0, 
        ref_0.name as c1, 
        ref_0.id as c2, 
        ref_0.id as c3, 
        ref_0.name as c4, 
        ref_0.id as c5, 
        ref_0.name as c6, 
        ref_0.id as c7, 
        ref_0.name as c8
      from 
        main.t0 as ref_0
      where 0
      limit 187) as subq_0
where cast(nullif(subq_0.c1,
    subq_0.c1) as VARCHAR(16)) is not NULL
limit 104;
