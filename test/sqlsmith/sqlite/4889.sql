select  
  (select id from main.t0 limit 1 offset 4)
     as c0, 
  67 as c1, 
  ref_0.id as c2, 
  ref_0.id as c3, 
  ref_0.id as c4, 
  ref_0.name as c5, 
  ref_0.name as c6
from 
  main.t0 as ref_0
where case when 0 then ref_0.id else ref_0.id end
     is not NULL
limit 47;
