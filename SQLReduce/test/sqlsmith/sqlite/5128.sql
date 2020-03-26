select  
  28 as c0, 
  ref_0.id as c1, 
  ref_0.name as c2, 
  case when EXISTS (
      select  
          ref_1.name as c0, 
          ref_1.id as c1, 
          (select name from main.t0 limit 1 offset 6)
             as c2, 
          ref_0.name as c3, 
          ref_0.name as c4, 
          83 as c5
        from 
          main.t0 as ref_1
        where ref_0.id is not NULL
        limit 60) then ref_0.id else ref_0.id end
     as c3
from 
  main.t0 as ref_0
where (select name from main.t0 limit 1 offset 60)
     is not NULL
limit 63;
