select  
  ref_0.name as c0, 
  ref_0.name as c1, 
  ref_0.name as c2, 
  ref_0.name as c3, 
  ref_0.id as c4
from 
  main.t0 as ref_0
where ((((select name from main.t0 limit 1 offset 3)
           is not NULL) 
      or (EXISTS (
        select  
            ref_0.id as c0, 
            ref_1.id as c1, 
            (select id from main.t0 limit 1 offset 3)
               as c2
          from 
            main.t0 as ref_1
          where (0) 
            or (ref_0.name is NULL)
          limit 8))) 
    and (0)) 
  or (0)
limit 57;
