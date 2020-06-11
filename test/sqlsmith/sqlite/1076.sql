select  
  ref_0.id as c0, 
  ref_0.name as c1, 
  case when 13 is NULL then cast(coalesce(ref_0.name,
      ref_0.name) as VARCHAR(16)) else cast(coalesce(ref_0.name,
      ref_0.name) as VARCHAR(16)) end
     as c2
from 
  main.t0 as ref_0
where EXISTS (
  select  
      ref_1.id as c0, 
      ref_1.id as c1
    from 
      main.t0 as ref_1
    where 0)
limit 87;
