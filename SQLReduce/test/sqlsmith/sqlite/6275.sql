select  
  cast(nullif(ref_0.id,
    cast(coalesce(cast(nullif(ref_0.id,
        ref_0.id) as INT),
      ref_0.id) as INT)) as INT) as c0
from 
  main.t0 as ref_0
where (case when ref_0.name is not NULL then ref_0.name else ref_0.name end
       is not NULL) 
  or (ref_0.name is not NULL)
limit 59;
