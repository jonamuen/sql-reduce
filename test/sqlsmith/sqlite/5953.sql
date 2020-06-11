select  
  (select name from main.t0 limit 1 offset 2)
     as c0
from 
  main.t0 as ref_0
where (1) 
  or (EXISTS (
    select  
        ref_0.id as c0
      from 
        main.t0 as ref_1
      where 1
      limit 102));
