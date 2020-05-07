select  
  ref_0.name as c0, 
  ref_0.id as c1, 
  ref_0.name as c2, 
  ref_0.name as c3, 
  ref_0.name as c4, 
  ref_0.id as c5, 
  case when 0 then ref_0.name else ref_0.name end
     as c6, 
  ref_0.name as c7, 
  ref_0.id as c8
from 
  main.t0 as ref_0
where cast(nullif(ref_0.name,
    case when ref_0.name is not NULL then ref_0.name else ref_0.name end
      ) as VARCHAR(16)) is NULL;
