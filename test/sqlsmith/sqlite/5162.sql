select  
  ref_0.id as c0, 
  ref_0.name as c1, 
  ref_0.name as c2, 
  ref_0.id as c3, 
  ref_0.id as c4, 
  (select name from main.t0 limit 1 offset 3)
     as c5, 
  ref_0.id as c6
from 
  main.t0 as ref_0
where (EXISTS (
    select  
        ref_1.name as c0, 
        ref_0.id as c1, 
        ref_1.id as c2, 
        5 as c3, 
        ref_0.name as c4, 
        (select id from main.t0 limit 1 offset 1)
           as c5, 
        ref_1.name as c6, 
        (select id from main.t0 limit 1 offset 2)
           as c7, 
        ref_0.id as c8, 
        ref_1.name as c9, 
        ref_1.name as c10, 
        ref_1.id as c11, 
        ref_0.id as c12, 
        ref_0.id as c13, 
        ref_0.name as c14, 
        ref_1.id as c15
      from 
        main.t0 as ref_1
      where ref_1.id is not NULL)) 
  or (ref_0.name is NULL)
limit 137;
