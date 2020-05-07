select  
  (select id from main.t0 limit 1 offset 4)
     as c0, 
  case when 0 then subq_0.c1 else subq_0.c1 end
     as c1
from 
  (select  
        ref_0.id as c0, 
        ref_0.name as c1
      from 
        main.t0 as ref_0
      where EXISTS (
        select  
            ref_1.name as c0, 
            ref_1.name as c1
          from 
            main.t0 as ref_1
          where 0)
      limit 63) as subq_0
where ((subq_0.c1 is not NULL) 
    and ((0) 
      or (0))) 
  and ((0) 
    or (subq_0.c1 is not NULL))
limit 167;
