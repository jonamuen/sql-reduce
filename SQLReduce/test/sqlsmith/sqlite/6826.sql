select  
  ref_0.name as c0, 
  (select id from main.t0 limit 1 offset 12)
     as c1, 
  ref_0.id as c2, 
  ref_0.id as c3, 
  ref_0.name as c4, 
  ref_0.name as c5, 
  case when (0) 
      or (ref_0.id is NULL) then ref_0.name else ref_0.name end
     as c6, 
  ref_0.name as c7, 
  cast(coalesce(case when ref_0.name is not NULL then case when ref_0.name is NULL then ref_0.id else ref_0.id end
         else case when ref_0.name is NULL then ref_0.id else ref_0.id end
         end
      ,
    ref_0.id) as INT) as c8, 
  case when 1 then ref_0.name else ref_0.name end
     as c9, 
  cast(coalesce(ref_0.name,
    ref_0.name) as VARCHAR(16)) as c10, 
  ref_0.name as c11, 
  ref_0.name as c12, 
  (select id from main.t0 limit 1 offset 94)
     as c13
from 
  main.t0 as ref_0
where EXISTS (
  select  
      ref_0.id as c0, 
      ref_1.name as c1
    from 
      main.t0 as ref_1
    where 1
    limit 109)
limit 116;
