select  
  ref_0.id as c0, 
  (select name from main.t0 limit 1 offset 3)
     as c1, 
  (select id from main.t0 limit 1 offset 28)
     as c2, 
  ref_0.id as c3, 
  ref_0.name as c4, 
  ref_0.name as c5, 
  71 as c6, 
  ref_0.name as c7, 
  ref_0.id as c8, 
  (select name from main.t0 limit 1 offset 1)
     as c9, 
  ref_0.id as c10, 
  ref_0.id as c11, 
  ref_0.name as c12
from 
  main.t0 as ref_0
where EXISTS (
  select  
      ref_0.id as c0
    from 
      (select  
            ref_1.id as c0, 
            ref_1.name as c1, 
            83 as c2, 
            (select name from main.t0 limit 1 offset 5)
               as c3
          from 
            main.t0 as ref_1
          where 1
          limit 97) as subq_0
    where 0
    limit 112)
limit 66;
