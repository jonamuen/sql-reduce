select  
  ref_0.id as c0, 
  ref_0.name as c1, 
  ref_0.id as c2, 
  (select name from main.t0 limit 1 offset 4)
     as c3, 
  (select id from main.t0 limit 1 offset 4)
     as c4, 
  ref_0.id as c5, 
  ref_0.name as c6
from 
  main.t0 as ref_0
where (case when ref_0.name is not NULL then ref_0.id else ref_0.id end
       is not NULL) 
  or ((select name from main.t0 limit 1 offset 2)
       is NULL);
