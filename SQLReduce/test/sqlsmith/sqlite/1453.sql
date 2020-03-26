select  
  ref_0.name as c0, 
  79 as c1, 
  ref_0.id as c2, 
  ref_0.id as c3, 
  ref_0.name as c4, 
  ref_0.id as c5, 
  78 as c6, 
  ref_0.name as c7, 
  ref_0.name as c8, 
  ref_0.name as c9, 
  cast(nullif(case when (((ref_0.name is not NULL) 
            or ((ref_0.name is not NULL) 
              and (ref_0.name is not NULL))) 
          or ((1) 
            and (ref_0.id is not NULL))) 
        or ((select id from main.t0 limit 1 offset 3)
             is not NULL) then ref_0.name else ref_0.name end
      ,
    cast(null as VARCHAR(16))) as VARCHAR(16)) as c10, 
  ref_0.name as c11, 
  (select id from main.t0 limit 1 offset 4)
     as c12, 
  cast(nullif(ref_0.name,
    ref_0.name) as VARCHAR(16)) as c13
from 
  main.t0 as ref_0
where ref_0.name is not NULL
limit 160;
