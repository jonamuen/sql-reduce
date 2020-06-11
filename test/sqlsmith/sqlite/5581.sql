select  
  case when subq_0.c0 is NULL then subq_0.c0 else subq_0.c0 end
     as c0, 
  subq_0.c0 as c1, 
  subq_0.c0 as c2
from 
  (select  
        ref_0.id as c0
      from 
        main.t0 as ref_0
      where ref_0.id is NULL) as subq_0
where (subq_0.c0 is NULL) 
  and ((subq_0.c0 is not NULL) 
    or (((1) 
        or (0)) 
      or ((subq_0.c0 is not NULL) 
        and (subq_0.c0 is not NULL))))
limit 137;
