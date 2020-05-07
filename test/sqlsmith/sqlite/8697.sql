select  
  ref_0.name as c0, 
  ref_0.id as c1, 
  ref_1.name as c2, 
  ref_1.name as c3, 
  ref_1.id as c4, 
  ref_0.name as c5, 
  ref_1.name as c6, 
  ref_1.name as c7, 
  ref_0.id as c8, 
  ref_0.name as c9, 
  ref_0.name as c10, 
  ref_1.id as c11, 
  ref_0.name as c12
from 
  main.t0 as ref_0
    inner join main.t0 as ref_1
    on (ref_1.id is not NULL)
where ((EXISTS (
      select  
          ref_2.id as c0, 
          ref_1.name as c1, 
          ref_0.id as c2, 
          ref_1.name as c3, 
          ref_1.name as c4, 
          ref_0.id as c5
        from 
          main.t0 as ref_2
        where ((ref_1.id is not NULL) 
            and ((0) 
              or ((0) 
                and (2 is NULL)))) 
          or ((1) 
            or (EXISTS (
              select  
                  ref_3.id as c0, 
                  ref_0.id as c1, 
                  ref_2.id as c2, 
                  ref_3.id as c3
                from 
                  main.t0 as ref_3
                where ref_0.id is not NULL
                limit 112)))
        limit 120)) 
    and ((85 is not NULL) 
      or (((select id from main.t0 limit 1 offset 4)
             is not NULL) 
        and ((ref_1.name is not NULL) 
          or (0))))) 
  and (ref_0.name is NULL);
