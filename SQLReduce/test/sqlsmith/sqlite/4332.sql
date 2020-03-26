select  
  ref_0.id as c0, 
  ref_0.name as c1, 
  ref_0.name as c2, 
  ref_0.name as c3, 
  ref_0.id as c4, 
  ref_0.id as c5, 
  ref_0.id as c6, 
  cast(nullif(case when (0) 
        and (ref_0.name is not NULL) then ref_0.id else ref_0.id end
      ,
    ref_0.id) as INT) as c7, 
  ref_0.name as c8, 
  ref_0.id as c9, 
  ref_0.id as c10
from 
  main.t0 as ref_0
where ref_0.name is NULL
limit 93;
