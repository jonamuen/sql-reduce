select  
  ref_0.id as c0, 
  (select id from main.t0 limit 1 offset 4)
     as c1, 
  ref_0.name as c2, 
  ref_0.name as c3, 
  ref_0.name as c4, 
  ref_0.name as c5, 
  ref_0.id as c6, 
  ref_0.id as c7
from 
  main.t0 as ref_0
where ((ref_0.id is NULL) 
    or ((ref_0.id is NULL) 
      and (((ref_0.name is not NULL) 
          and (ref_0.id is NULL)) 
        and (((1) 
            and ((((ref_0.id is not NULL) 
                  or (ref_0.id is NULL)) 
                and ((ref_0.name is NULL) 
                  or ((0) 
                    and ((1) 
                      or (0))))) 
              and ((ref_0.name is not NULL) 
                or (ref_0.id is NULL)))) 
          or ((EXISTS (
              select  
                  ref_1.name as c0
                from 
                  main.t0 as ref_1
                where ref_1.id is NULL
                limit 187)) 
            or ((0) 
              or (ref_0.name is NULL))))))) 
  or (1)
limit 173;
