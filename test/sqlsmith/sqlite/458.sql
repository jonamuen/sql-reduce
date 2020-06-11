select  
  (select name from main.t0 limit 1 offset 6)
     as c0, 
  ref_0.name as c1, 
  ref_0.name as c2, 
  ref_0.name as c3, 
  (select name from main.t0 limit 1 offset 43)
     as c4, 
  ref_0.name as c5, 
  ref_0.id as c6, 
  case when ((ref_0.name is NULL) 
        or ((select name from main.t0 limit 1 offset 1)
             is NULL)) 
      or (((1) 
          or (ref_0.name is NULL)) 
        or ((0) 
          and (1))) then ref_0.id else ref_0.id end
     as c7, 
  case when 1 then ref_0.id else ref_0.id end
     as c8
from 
  main.t0 as ref_0
where ref_0.name is NULL
limit 65;
