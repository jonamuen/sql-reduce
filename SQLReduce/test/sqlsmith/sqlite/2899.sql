select  
  subq_0.c0 as c0, 
  subq_0.c2 as c1, 
  (select name from main.t0 limit 1 offset 13)
     as c2, 
  cast(nullif(case when subq_0.c2 is NULL then subq_0.c0 else subq_0.c0 end
      ,
    subq_0.c2) as VARCHAR(16)) as c3, 
  subq_0.c2 as c4, 
  subq_0.c0 as c5, 
  case when 1 then subq_0.c2 else subq_0.c2 end
     as c6, 
  subq_0.c2 as c7, 
  cast(coalesce(subq_0.c1,
    subq_0.c1) as INT) as c8
from 
  (select  
        ref_0.name as c0, 
        (select id from main.t0 limit 1 offset 5)
           as c1, 
        ref_0.name as c2
      from 
        main.t0 as ref_0
      where 1 is not NULL
      limit 152) as subq_0
where ((subq_0.c0 is not NULL) 
    or ((1) 
      and ((subq_0.c0 is not NULL) 
        and ((select name from main.t0 limit 1 offset 72)
             is not NULL)))) 
  and (subq_0.c2 is not NULL);
