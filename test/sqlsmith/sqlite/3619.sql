select  
  ref_0.name as c0, 
  ref_0.name as c1, 
  ref_0.name as c2, 
  ref_0.name as c3, 
  ref_0.id as c4, 
  ref_0.name as c5, 
  ref_0.name as c6
from 
  main.t0 as ref_0
where (ref_0.name is NULL) 
  or (EXISTS (
    select  
        ref_1.id as c0, 
        ref_0.id as c1, 
        ref_0.id as c2, 
        ref_1.name as c3
      from 
        main.t0 as ref_1
      where case when ref_0.name is NULL then ref_1.id else ref_1.id end
           is not NULL))
limit 37;
