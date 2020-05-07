select  
  ref_0.id as c0, 
  ref_0.id as c1, 
  ref_0.name as c2
from 
  main.t0 as ref_0
    left join (select  
          ref_1.name as c0, 
          ref_1.name as c1, 
          ref_1.name as c2, 
          ref_1.id as c3, 
          ref_1.name as c4, 
          ref_1.name as c5, 
          ref_1.id as c6
        from 
          main.t0 as ref_1
        where 0
        limit 120) as subq_0
    on (cast(nullif(subq_0.c2,
          subq_0.c0) as VARCHAR(16)) is NULL)
where 1
limit 81;
