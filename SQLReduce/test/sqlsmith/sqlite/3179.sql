select  
  cast(nullif(subq_0.c0,
    case when subq_0.c0 is not NULL then subq_0.c1 else subq_0.c1 end
      ) as INT) as c0
from 
  (select  
        (select id from main.t0 limit 1 offset 6)
           as c0, 
        ref_0.id as c1
      from 
        main.t0 as ref_0
      where ref_0.name is not NULL) as subq_0
where (0) 
  or ((select id from main.t0 limit 1 offset 6)
       is NULL);
