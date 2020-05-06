select  
  ref_0.name as c0, 
  ref_0.id as c1, 
  ref_0.name as c2, 
  cast(nullif((select id from main.t0 limit 1 offset 2)
      ,
    ref_0.id) as INT) as c3, 
  ref_0.id as c4, 
  ref_0.id as c5
from 
  main.t0 as ref_0
where EXISTS (
  select  
      ref_0.id as c0, 
      ref_0.id as c1
    from 
      (select  
            52 as c0, 
            ref_1.id as c1, 
            ref_0.name as c2, 
            ref_1.name as c3
          from 
            main.t0 as ref_1
          where ((0) 
              or (0)) 
            or (ref_1.id is NULL)
          limit 135) as subq_0
    where ref_0.name is not NULL)
limit 89;
