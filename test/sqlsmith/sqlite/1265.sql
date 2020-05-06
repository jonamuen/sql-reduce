select  
  ref_0.id as c0, 
  ref_0.name as c1, 
  ref_0.id as c2, 
  ref_0.id as c3, 
  ref_0.name as c4, 
  ref_0.name as c5, 
  ref_0.name as c6, 
  15 as c7, 
  ref_0.name as c8, 
  case when 1 then (select id from main.t0 limit 1 offset 4)
       else (select id from main.t0 limit 1 offset 4)
       end
     as c9, 
  cast(coalesce((select name from main.t0 limit 1 offset 4)
      ,
    ref_0.name) as VARCHAR(16)) as c10, 
  case when ref_0.id is NULL then ref_0.name else ref_0.name end
     as c11, 
  ref_0.name as c12, 
  ref_0.id as c13, 
  ref_0.name as c14, 
  ref_0.id as c15
from 
  main.t0 as ref_0
where ref_0.id is not NULL
limit 43;
