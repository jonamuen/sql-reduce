select  
  case when (((0) 
          or (1)) 
        and ((1) 
          and ((1) 
            and (subq_0.c1 is not NULL)))) 
      or ((cast(nullif((select name from main.t0 limit 1 offset 3)
              ,
            subq_0.c2) as VARCHAR(16)) is not NULL) 
        and (1)) then subq_0.c0 else subq_0.c0 end
     as c0, 
  subq_0.c0 as c1, 
  subq_0.c0 as c2
from 
  (select  
        ref_0.id as c0, 
        ref_0.id as c1, 
        ref_0.name as c2, 
        ref_0.name as c3
      from 
        main.t0 as ref_0
      where (ref_0.name is not NULL) 
        or (ref_0.id is NULL)
      limit 104) as subq_0
where 1;
