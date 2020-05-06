select  
  ref_0.name as c0
from 
  main.t0 as ref_0
where (EXISTS (
    select  
        ref_1.name as c0, 
        ref_0.name as c1, 
        ref_1.name as c2, 
        ref_1.id as c3, 
        ref_1.name as c4, 
        (select name from main.t0 limit 1 offset 2)
           as c5, 
        ref_0.name as c6, 
        ref_0.name as c7, 
        ref_0.id as c8, 
        ref_1.name as c9, 
        ref_1.name as c10, 
        ref_0.id as c11, 
        ref_1.id as c12, 
        ref_0.name as c13, 
        ref_1.name as c14, 
        ref_0.id as c15, 
        ref_1.name as c16, 
        ref_0.name as c17, 
        (select name from main.t0 limit 1 offset 3)
           as c18, 
        ref_1.id as c19, 
        ref_1.name as c20, 
        ref_1.id as c21
      from 
        main.t0 as ref_1
      where ((ref_1.name is NULL) 
          and ((0) 
            or (ref_1.name is not NULL))) 
        and (ref_0.name is NULL))) 
  and (ref_0.id is not NULL)
limit 90;
