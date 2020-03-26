select  
  (select id from main.t0 limit 1 offset 5)
     as c0, 
  ref_0.name as c1, 
  ref_0.name as c2, 
  ref_0.name as c3, 
  ref_0.id as c4, 
  cast(coalesce(ref_0.name,
    case when 0 then ref_0.name else ref_0.name end
      ) as VARCHAR(16)) as c5, 
  case when 74 is not NULL then ref_0.name else ref_0.name end
     as c6, 
  ref_0.id as c7, 
  ref_0.name as c8, 
  ref_0.id as c9
from 
  main.t0 as ref_0
where ref_0.id is NULL
limit 51;
