select  
  case when ((1) 
        and ((1) 
          or (((subq_0.c2 is NULL) 
              or (subq_0.c1 is not NULL)) 
            or ((select id from main.t0 limit 1 offset 3)
                 is NULL)))) 
      or ((1) 
        or (subq_0.c2 is NULL)) then subq_0.c3 else subq_0.c3 end
     as c0, 
  subq_0.c0 as c1, 
  subq_0.c2 as c2, 
  subq_0.c5 as c3
from 
  (select  
        ref_0.id as c0, 
        ref_0.id as c1, 
        ref_0.id as c2, 
        ref_0.id as c3, 
        ref_0.name as c4, 
        ref_0.name as c5, 
        ref_0.name as c6
      from 
        main.t0 as ref_0
      where (select id from main.t0 limit 1 offset 5)
           is NULL) as subq_0
where (subq_0.c0 is NULL) 
  or (0);
