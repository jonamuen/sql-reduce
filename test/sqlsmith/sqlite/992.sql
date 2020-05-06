select  
  cast(nullif(subq_0.c1,
    subq_0.c1) as VARCHAR(16)) as c0
from 
  (select  
        ref_0.id as c0, 
        ref_0.name as c1
      from 
        main.t0 as ref_0
      where EXISTS (
        select  
            ref_0.name as c0
          from 
            main.t0 as ref_1
          where ref_0.name is not NULL)
      limit 45) as subq_0
where case when subq_0.c0 is not NULL then subq_0.c0 else subq_0.c0 end
     is not NULL;
