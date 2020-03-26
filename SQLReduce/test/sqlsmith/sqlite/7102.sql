select  
  ref_0.name as c0, 
  ref_0.id as c1, 
  ref_0.name as c2, 
  ref_0.name as c3, 
  ref_0.id as c4, 
  85 as c5, 
  ref_0.name as c6, 
  case when (ref_0.id is NULL) 
      and ((1) 
        and (((1) 
            or (((0) 
                and (ref_0.id is not NULL)) 
              or (ref_0.id is not NULL))) 
          and ((ref_0.name is not NULL) 
            or (ref_0.id is NULL)))) then ref_0.name else ref_0.name end
     as c7, 
  ref_0.id as c8, 
  ref_0.id as c9, 
  ref_0.id as c10, 
  cast(coalesce(cast(nullif(ref_0.id,
      ref_0.id) as INT),
    ref_0.id) as INT) as c11, 
  ref_0.name as c12, 
  ref_0.name as c13, 
  ref_0.name as c14, 
  ref_0.name as c15, 
  71 as c16, 
  ref_0.id as c17, 
  ref_0.name as c18, 
  ref_0.name as c19, 
  ref_0.name as c20
from 
  main.t0 as ref_0
where 0
limit 57;
