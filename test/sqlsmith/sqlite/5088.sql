select  
  ref_0.id as c0, 
  ref_0.name as c1, 
  ref_0.id as c2, 
  cast(nullif(cast(coalesce(ref_0.name,
      ref_0.name) as VARCHAR(16)),
    ref_0.name) as VARCHAR(16)) as c3, 
  ref_0.id as c4, 
  ref_0.id as c5, 
  ref_0.name as c6, 
  case when EXISTS (
      select  
          ref_1.name as c0, 
          ref_0.name as c1, 
          ref_0.id as c2, 
          ref_0.name as c3
        from 
          main.t0 as ref_1
        where ref_0.id is NULL
        limit 104) then cast(coalesce(ref_0.id,
      ref_0.id) as INT) else cast(coalesce(ref_0.id,
      ref_0.id) as INT) end
     as c7, 
  (select id from main.t0 limit 1 offset 1)
     as c8, 
  ref_0.id as c9
from 
  main.t0 as ref_0
where 0;
