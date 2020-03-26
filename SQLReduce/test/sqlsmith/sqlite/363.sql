select  
  ref_0.name as c0, 
  ref_0.name as c1
from 
  main.t0 as ref_0
where EXISTS (
  select  
      ref_1.id as c0, 
      ref_0.id as c1, 
      ref_0.name as c2, 
      ref_0.name as c3
    from 
      main.t0 as ref_1
    where ref_1.name is NULL)
limit 105;
