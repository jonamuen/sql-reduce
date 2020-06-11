select  
  subq_0.c2 as c0, 
  subq_0.c1 as c1, 
  case when 1 then subq_0.c5 else subq_0.c5 end
     as c2, 
  subq_0.c3 as c3, 
  subq_0.c0 as c4
from 
  (select  
        ref_0.name as c0, 
        ref_0.id as c1, 
        ref_0.name as c2, 
        ref_0.name as c3, 
        ref_0.name as c4, 
        ref_0.id as c5, 
        ref_0.name as c6
      from 
        main.t0 as ref_0
      where ((ref_0.name is not NULL) 
          or (((1) 
              and ((1) 
                and (0))) 
            and ((ref_0.id is not NULL) 
              or (0)))) 
        or (ref_0.name is NULL)
      limit 138) as subq_0
where 1
limit 64;
