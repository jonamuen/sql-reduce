select  
  cast(coalesce(ref_0.name,
    case when ref_0.name is NULL then ref_0.name else ref_0.name end
      ) as VARCHAR(16)) as c0, 
  ref_0.name as c1, 
  ref_0.name as c2, 
  ref_0.name as c3, 
  ref_0.id as c4, 
  ref_0.id as c5, 
  ref_0.name as c6, 
  ref_0.id as c7, 
  ref_0.id as c8, 
  (select name from main.t0 limit 1 offset 6)
     as c9, 
  ref_0.id as c10
from 
  main.t0 as ref_0
where (0) 
  or (ref_0.id is not NULL);
