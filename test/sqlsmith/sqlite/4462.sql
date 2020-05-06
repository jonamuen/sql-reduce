select  
  ref_0.name as c0, 
  ref_0.id as c1, 
  ref_0.id as c2
from 
  main.t0 as ref_0
where (97 is NULL) 
  or (EXISTS (
    select  
        ref_0.name as c0, 
        (select id from main.t0 limit 1 offset 5)
           as c1
      from 
        main.t0 as ref_1
      where 1
      limit 120));
