select  
  ref_1.name as c0, 
  ref_1.name as c1, 
  cast(nullif(ref_1.name,
    ref_1.name) as VARCHAR(16)) as c2, 
  ref_1.name as c3, 
  cast(coalesce((select name from main.t0 limit 1 offset 2)
      ,
    subq_1.c2) as VARCHAR(16)) as c4, 
  subq_1.c0 as c5, 
  subq_1.c2 as c6
from 
  (select  
          (select id from main.t0 limit 1 offset 6)
             as c0, 
          subq_0.c0 as c1, 
          subq_0.c2 as c2
        from 
          (select  
                ref_0.id as c0, 
                ref_0.name as c1, 
                ref_0.name as c2
              from 
                main.t0 as ref_0
              where ref_0.id is NULL
              limit 41) as subq_0
        where (0) 
          or (subq_0.c1 is NULL)
        limit 88) as subq_1
    left join main.t0 as ref_1
    on (subq_1.c2 = ref_1.name )
where subq_1.c0 is NULL
limit 129;
