select  
  ref_0.id as c0, 
  (select name from main.t0 limit 1 offset 1)
     as c1, 
  ref_0.name as c2, 
  ref_0.name as c3, 
  cast(coalesce(ref_0.id,
    ref_0.id) as INT) as c4, 
  ref_0.id as c5, 
  ref_0.id as c6, 
  54 as c7, 
  ref_0.id as c8, 
  (select id from main.t0 limit 1 offset 5)
     as c9, 
  case when 0 then ref_0.name else ref_0.name end
     as c10, 
  ref_0.id as c11, 
  case when (ref_0.id is NULL) 
      and (ref_0.name is not NULL) then (select id from main.t0 limit 1 offset 2)
       else (select id from main.t0 limit 1 offset 2)
       end
     as c12, 
  90 as c13, 
  20 as c14, 
  ref_0.id as c15, 
  ref_0.name as c16, 
  case when 1 then ref_0.id else ref_0.id end
     as c17, 
  ref_0.id as c18, 
  ref_0.id as c19, 
  ref_0.id as c20, 
  ref_0.name as c21, 
  ref_0.name as c22, 
  ref_0.id as c23
from 
  main.t0 as ref_0
where ref_0.id is NULL
limit 195;
