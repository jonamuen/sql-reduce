select  
  ref_0.name as c0, 
  ref_0.name as c1, 
  case when ((1) 
        and ((ref_0.name is not NULL) 
          or ((ref_0.name is not NULL) 
            or (EXISTS (
              select  
                  ref_0.name as c0, 
                  ref_0.name as c1, 
                  ref_0.name as c2, 
                  ref_0.name as c3, 
                  ref_1.id as c4, 
                  ref_1.name as c5, 
                  ref_0.id as c6, 
                  ref_0.name as c7, 
                  ref_0.id as c8, 
                  ref_1.name as c9, 
                  ref_1.name as c10, 
                  (select name from main.t0 limit 1 offset 2)
                     as c11
                from 
                  main.t0 as ref_1
                where (1) 
                  or (0)))))) 
      and (0) then ref_0.id else ref_0.id end
     as c2, 
  case when (select name from main.t0 limit 1 offset 3)
         is NULL then ref_0.id else ref_0.id end
     as c3, 
  ref_0.name as c4
from 
  main.t0 as ref_0
where (0) 
  and (EXISTS (
    select  
        (select id from main.t0 limit 1 offset 82)
           as c0
      from 
        main.t0 as ref_2
      where (EXISTS (
          select  
              ref_0.name as c0
            from 
              main.t0 as ref_3
            where ((0) 
                or (ref_2.id is not NULL)) 
              or (1)
            limit 145)) 
        or (((ref_0.name is not NULL) 
            and (ref_0.id is not NULL)) 
          and (0))
      limit 25))
limit 94;
