select  
  subq_0.c0 as c0, 
  case when ((0) 
        and (subq_0.c2 is not NULL)) 
      and ((subq_0.c0 is not NULL) 
        and (cast(coalesce(subq_0.c5,
            subq_0.c7) as INT) is not NULL)) then subq_0.c5 else subq_0.c5 end
     as c1, 
  (select id from main.t0 limit 1 offset 5)
     as c2, 
  subq_0.c3 as c3
from 
  (select  
        (select name from main.t0 limit 1 offset 5)
           as c0, 
        (select name from main.t0 limit 1 offset 6)
           as c1, 
        ref_0.name as c2, 
        86 as c3, 
        ref_0.name as c4, 
        ref_0.id as c5, 
        ref_0.name as c6, 
        ref_0.id as c7
      from 
        main.t0 as ref_0
      where (EXISTS (
          select  
              ref_1.name as c0, 
              (select name from main.t0 limit 1 offset 58)
                 as c1, 
              ref_0.id as c2, 
              ref_1.name as c3
            from 
              main.t0 as ref_1
            where ref_0.id is not NULL
            limit 135)) 
        and (ref_0.id is NULL)
      limit 54) as subq_0
where (subq_0.c4 is NULL) 
  or (((1) 
      and ((1) 
        and (0))) 
    or (100 is not NULL))
limit 109;
