select  
  ref_0.id as c0, 
  ref_0.name as c1
from 
  main.t0 as ref_0
where ((ref_0.id is not NULL) 
    or (ref_0.id is NULL)) 
  and (EXISTS (
    select  
        ref_1.id as c0, 
        cast(nullif(ref_1.name,
          ref_1.name) as VARCHAR(16)) as c1
      from 
        main.t0 as ref_1
      where 1));
