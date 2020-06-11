select  
  cast(coalesce(ref_0.id,
    ref_0.id) as INT) as c0, 
  ref_0.name as c1, 
  ref_0.id as c2, 
  ref_0.id as c3, 
  ref_0.id as c4, 
  ref_0.id as c5, 
  ref_0.id as c6, 
  ref_0.id as c7, 
  ref_0.id as c8, 
  cast(coalesce((select id from main.t0 limit 1 offset 6)
      ,
    cast(null as INT)) as INT) as c9, 
  ref_0.name as c10, 
  case when 0 then ref_0.id else ref_0.id end
     as c11, 
  (select name from main.t0 limit 1 offset 48)
     as c12, 
  cast(nullif(ref_0.name,
    ref_0.name) as VARCHAR(16)) as c13, 
  ref_0.id as c14, 
  ref_0.name as c15, 
  ref_0.id as c16
from 
  main.t0 as ref_0
where ref_0.id is NULL
limit 123;
