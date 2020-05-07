select  
  (select id from main.t0 limit 1 offset 1)
     as c0
from 
  main.t0 as ref_0
where cast(nullif(ref_0.name,
    ref_0.name) as VARCHAR(16)) is NULL;
