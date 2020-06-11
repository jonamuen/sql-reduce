select  
  case when (1) 
      or ((ref_0.id is not NULL) 
        or ((ref_0.name is not NULL) 
          and (1))) then ref_0.id else ref_0.id end
     as c0, 
  ref_0.id as c1, 
  ref_0.id as c2, 
  cast(coalesce(ref_0.id,
    ref_0.id) as INT) as c3, 
  ref_0.name as c4, 
  ref_0.name as c5, 
  ref_0.name as c6, 
  ref_0.name as c7, 
  case when ref_0.name is not NULL then ref_0.name else ref_0.name end
     as c8, 
  ref_0.name as c9, 
  ref_0.id as c10, 
  case when ref_0.id is NULL then ref_0.id else ref_0.id end
     as c11, 
  ref_0.name as c12, 
  85 as c13, 
  ref_0.id as c14, 
  ref_0.id as c15, 
  ref_0.id as c16, 
  ref_0.id as c17, 
  cast(coalesce(ref_0.id,
    cast(null as INT)) as INT) as c18
from 
  main.t0 as ref_0
where ref_0.name is NULL;
