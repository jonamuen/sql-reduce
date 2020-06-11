select  
  ref_0.id as c0, 
  ref_0.name as c1, 
  ref_0.id as c2, 
  ref_0.id as c3, 
  ref_0.name as c4, 
  cast(nullif(ref_0.name,
    ref_0.name) as VARCHAR(16)) as c5, 
  case when ref_0.id is not NULL then ref_0.id else ref_0.id end
     as c6
from 
  main.t0 as ref_0
where (0) 
  or (((select id from main.t0 limit 1 offset 15)
         is not NULL) 
    or ((0) 
      and (ref_0.name is NULL)));
