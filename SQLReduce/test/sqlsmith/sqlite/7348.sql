select  
  ref_0.name as c0, 
  (select name from main.t0 limit 1 offset 6)
     as c1, 
  cast(coalesce(ref_0.name,
    ref_0.name) as VARCHAR(16)) as c2, 
  ref_0.name as c3, 
  case when ref_0.name is not NULL then ref_0.name else ref_0.name end
     as c4, 
  ref_0.name as c5, 
  ref_0.name as c6
from 
  main.t0 as ref_0
where (ref_0.id is NULL) 
  or (((select id from main.t0 limit 1 offset 4)
         is NULL) 
    and (EXISTS (
      select distinct 
          ref_0.id as c0, 
          ref_0.id as c1, 
          ref_1.id as c2, 
          ref_1.id as c3
        from 
          main.t0 as ref_1
        where 0
        limit 49)))
limit 136;
