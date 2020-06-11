select  
  ref_0.name as c0, 
  cast(coalesce(case when ref_0.name is NULL then ref_0.name else ref_0.name end
      ,
    ref_0.name) as VARCHAR(16)) as c1, 
  ref_0.name as c2, 
  case when ref_0.id is not NULL then ref_0.name else ref_0.name end
     as c3, 
  ref_0.name as c4, 
  ref_0.name as c5
from 
  main.t0 as ref_0
where ref_0.name is NULL;
