select  
  ref_0.id as c0, 
  ref_0.name as c1, 
  cast(coalesce(ref_0.name,
    ref_0.name) as VARCHAR(16)) as c2, 
  case when (ref_0.name is NULL) 
      or (case when ((ref_0.id is not NULL) 
              or ((1) 
                or ((select id from main.t0 limit 1 offset 1)
                     is not NULL))) 
            or (1) then ref_0.id else ref_0.id end
           is NULL) then (select id from main.t0 limit 1 offset 5)
       else (select id from main.t0 limit 1 offset 5)
       end
     as c3, 
  ref_0.name as c4, 
  cast(nullif(77,
    49) as INTEGER) as c5, 
  case when 0 then ref_0.name else ref_0.name end
     as c6, 
  ref_0.name as c7, 
  case when 1 then ref_0.id else ref_0.id end
     as c8, 
  ref_0.id as c9, 
  ref_0.id as c10, 
  ref_0.id as c11
from 
  main.t0 as ref_0
where ref_0.id is NULL
limit 122;
