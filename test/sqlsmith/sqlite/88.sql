select  
  subq_0.c10 as c0, 
  case when ((0) 
        and (0)) 
      or (case when subq_0.c8 is NULL then subq_0.c7 else subq_0.c7 end
           is NULL) then subq_0.c2 else subq_0.c2 end
     as c1, 
  subq_0.c10 as c2
from 
  (select  
        ref_0.id as c0, 
        ref_0.name as c1, 
        ref_0.id as c2, 
        ref_0.id as c3, 
        ref_0.id as c4, 
        ref_0.id as c5, 
        ref_0.name as c6, 
        ref_0.name as c7, 
        (select name from main.t0 limit 1 offset 3)
           as c8, 
        ref_0.id as c9, 
        ref_0.id as c10
      from 
        main.t0 as ref_0
      where 77 is NULL
      limit 77) as subq_0
where subq_0.c5 is NULL
limit 187;
