select  
  ref_0.id as c0, 
  ref_0.id as c1, 
  ref_0.name as c2, 
  ref_0.id as c3, 
  ref_0.id as c4, 
  (select id from main.t0 limit 1 offset 29)
     as c5
from 
  main.t0 as ref_0
where EXISTS (
  select  
      ref_0.id as c0, 
      ref_0.id as c1, 
      ref_0.name as c2, 
      ref_0.name as c3, 
      ref_1.id as c4
    from 
      main.t0 as ref_1
    where (select id from main.t0 limit 1 offset 4)
         is not NULL
    limit 112)
limit 93;
