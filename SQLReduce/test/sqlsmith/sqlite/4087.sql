select  
  subq_0.c0 as c0, 
  20 as c1, 
  subq_0.c0 as c2, 
  subq_0.c0 as c3, 
  subq_0.c0 as c4, 
  cast(coalesce(subq_0.c0,
    subq_0.c0) as VARCHAR(16)) as c5, 
  subq_0.c0 as c6, 
  case when 1 then subq_0.c0 else subq_0.c0 end
     as c7, 
  21 as c8
from 
  (select  
        ref_1.name as c0
      from 
        main.t0 as ref_0
          inner join main.t0 as ref_1
          on (ref_0.name is not NULL)
      where 1) as subq_0
where subq_0.c0 is NULL
limit 112;
