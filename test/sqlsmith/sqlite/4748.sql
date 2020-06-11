select  
  ref_1.id as c0, 
  cast(nullif(ref_1.name,
    ref_0.name) as VARCHAR(16)) as c1, 
  (select id from main.t0 limit 1 offset 6)
     as c2, 
  ref_0.id as c3, 
  ref_0.id as c4, 
  ref_1.id as c5, 
  ref_0.name as c6, 
  cast(nullif(ref_1.name,
    ref_1.name) as VARCHAR(16)) as c7, 
  ref_1.id as c8, 
  ref_0.id as c9
from 
  main.t0 as ref_0
    left join main.t0 as ref_1
    on (ref_1.id is not NULL)
where ref_0.name is NULL
limit 158;
