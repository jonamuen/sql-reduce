select  
  ref_0.id as c0, 
  ref_0.id as c1, 
  ref_0.name as c2, 
  ref_0.id as c3, 
  ref_0.name as c4, 
  ref_0.name as c5, 
  (select name from main.t0 limit 1 offset 4)
     as c6, 
  ref_0.id as c7, 
  ref_0.name as c8, 
  ref_0.name as c9, 
  61 as c10, 
  ref_0.id as c11
from 
  main.t0 as ref_0
where (((1) 
      or ((22 is NULL) 
        or (ref_0.name is NULL))) 
    or ((ref_0.name is not NULL) 
      and (ref_0.id is not NULL))) 
  and (ref_0.id is NULL);
