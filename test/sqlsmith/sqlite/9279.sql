select  
  ref_0.id as c0, 
  ref_0.name as c1, 
  ref_0.name as c2, 
  ref_0.name as c3, 
  ref_0.id as c4, 
  (select name from main.t0 limit 1 offset 21)
     as c5, 
  ref_0.name as c6, 
  37 as c7, 
  ref_0.name as c8, 
  ref_0.name as c9, 
  ref_0.id as c10, 
  ref_0.name as c11, 
  63 as c12
from 
  main.t0 as ref_0
where (1) 
  or ((((((ref_0.id is NULL) 
            or (ref_0.name is not NULL)) 
          or (0)) 
        and ((46 is not NULL) 
          and (((ref_0.id is not NULL) 
              and (0)) 
            and ((ref_0.id is NULL) 
              or (ref_0.name is NULL))))) 
      or ((ref_0.name is not NULL) 
        or (63 is not NULL))) 
    and ((((ref_0.name is NULL) 
          and ((EXISTS (
              select  
                  ref_1.name as c0, 
                  ref_1.name as c1, 
                  ref_1.id as c2, 
                  (select id from main.t0 limit 1 offset 3)
                     as c3, 
                  ref_1.name as c4, 
                  (select name from main.t0 limit 1 offset 5)
                     as c5, 
                  ref_1.name as c6
                from 
                  main.t0 as ref_1
                where ref_0.id is not NULL
                limit 128)) 
            or (0))) 
        or (0)) 
      and (ref_0.name is not NULL)));
