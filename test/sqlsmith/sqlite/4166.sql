select  
  ref_0.id as c0
from 
  main.t0 as ref_0
where EXISTS (
  select  
      49 as c0, 
      ref_1.id as c1, 
      ref_1.name as c2, 
      ref_0.id as c3, 
      ref_1.name as c4, 
      ref_1.name as c5, 
      ref_1.name as c6, 
      (select name from main.t0 limit 1 offset 5)
         as c7, 
      (select id from main.t0 limit 1 offset 6)
         as c8
    from 
      main.t0 as ref_1
    where ref_1.id is not NULL
    limit 120);
