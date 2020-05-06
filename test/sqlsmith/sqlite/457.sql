select  
  ref_0.name as c0, 
  ref_0.id as c1, 
  (select name from main.t0 limit 1 offset 6)
     as c2, 
  ref_0.name as c3, 
  ref_0.name as c4, 
  ref_0.name as c5, 
  ref_0.name as c6, 
  28 as c7, 
  ref_0.name as c8, 
  ref_0.id as c9, 
  13 as c10, 
  ref_0.name as c11, 
  case when ((ref_0.name is NULL) 
        and ((((ref_0.name is not NULL) 
              and (1)) 
            or ((1) 
              and (0))) 
          or (ref_0.id is not NULL))) 
      and ((ref_0.name is NULL) 
        and (ref_0.id is NULL)) then ref_0.name else ref_0.name end
     as c12, 
  ref_0.id as c13, 
  ref_0.id as c14, 
  ref_0.id as c15, 
  cast(nullif(ref_0.name,
    ref_0.name) as VARCHAR(16)) as c16, 
  ref_0.name as c17, 
  ref_0.id as c18, 
  ref_0.id as c19, 
  ref_0.id as c20
from 
  main.t0 as ref_0
where (0) 
  or ((cast(coalesce(ref_0.name,
        ref_0.name) as VARCHAR(16)) is not NULL) 
    or ((0) 
      and (ref_0.id is not NULL)));
