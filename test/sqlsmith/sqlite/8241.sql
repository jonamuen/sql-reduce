select  
  ref_0.name as c0, 
  ref_0.id as c1, 
  ref_0.id as c2, 
  ref_0.name as c3, 
  ref_0.name as c4, 
  ref_0.name as c5
from 
  main.t0 as ref_0
where EXISTS (
  select  
      ref_1.name as c0, 
      ref_1.name as c1, 
      ref_0.name as c2, 
      ref_1.id as c3, 
      cast(nullif(ref_1.id,
        ref_1.id) as INT) as c4
    from 
      main.t0 as ref_1
    where ref_0.name is not NULL
    limit 92)
limit 99;
