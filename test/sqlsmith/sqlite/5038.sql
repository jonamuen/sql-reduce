select  
  subq_0.c1 as c0
from 
  (select  
        ref_0.id as c0, 
        ref_0.id as c1, 
        ref_0.name as c2, 
        ref_0.id as c3
      from 
        main.t0 as ref_0
      where ((((1) 
              or (ref_0.name is not NULL)) 
            and (ref_0.name is NULL)) 
          or (1)) 
        or (((1) 
            or ((0) 
              and (ref_0.id is not NULL))) 
          and ((EXISTS (
              select  
                  ref_0.id as c0, 
                  (select name from main.t0 limit 1 offset 6)
                     as c1, 
                  (select name from main.t0 limit 1 offset 76)
                     as c2, 
                  ref_1.id as c3, 
                  ref_1.id as c4, 
                  ref_0.name as c5
                from 
                  main.t0 as ref_1
                where 1
                limit 83)) 
            and (ref_0.id is not NULL)))) as subq_0
where 1;
