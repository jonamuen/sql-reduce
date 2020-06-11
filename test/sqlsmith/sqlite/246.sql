select  
  ref_0.name as c0
from 
  main.t0 as ref_0
where (ref_0.name is NULL) 
  or (((1) 
      or (1)) 
    and ((1) 
      and (EXISTS (
        select  
            ref_0.id as c0, 
            22 as c1
          from 
            main.t0 as ref_1
          where ref_1.id is NULL))));
