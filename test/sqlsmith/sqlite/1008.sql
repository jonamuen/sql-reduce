select  
  ref_0.id as c0, 
  ref_0.name as c1
from 
  main.t0 as ref_0
where (cast(nullif(ref_0.name,
      case when 1 then ref_0.name else ref_0.name end
        ) as VARCHAR(16)) is NULL) 
  or (1)
limit 148;
