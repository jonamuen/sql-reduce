select  
  ref_1.id as c0, 
  ref_0.id as c1
from 
  main.t0 as ref_0
    inner join main.t0 as ref_1
    on ((0) 
        or (0))
where ((ref_0.id is NULL) 
    or (0)) 
  and (cast(nullif(ref_0.id,
      ref_1.id) as INT) is NULL);
