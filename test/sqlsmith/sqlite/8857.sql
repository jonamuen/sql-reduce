select  
  ref_0.id as c0, 
  cast(nullif(case when ref_0.id is NULL then ref_0.id else ref_0.id end
      ,
    ref_0.id) as INT) as c1, 
  ref_0.id as c2, 
  (select name from main.t0 limit 1 offset 5)
     as c3, 
  case when ref_0.id is NULL then ref_0.name else ref_0.name end
     as c4
from 
  main.t0 as ref_0
where ref_0.id is not NULL
limit 62;
