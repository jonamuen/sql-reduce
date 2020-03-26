select  
  cast(coalesce(case when ref_0.name is not NULL then ref_0.id else ref_0.id end
      ,
    ref_0.id) as INT) as c0, 
  ref_0.name as c1, 
  ref_0.name as c2
from 
  main.t0 as ref_0
where 1
limit 162;
