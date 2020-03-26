select  
  subq_0.c0 as c0, 
  subq_0.c0 as c1, 
  subq_0.c0 as c2, 
  subq_0.c0 as c3, 
  cast(coalesce(subq_0.c0,
    subq_0.c0) as VARCHAR(16)) as c4, 
  case when (0) 
      or (0) then subq_0.c0 else subq_0.c0 end
     as c5, 
  case when 94 is not NULL then subq_0.c0 else subq_0.c0 end
     as c6, 
  subq_0.c0 as c7, 
  subq_0.c0 as c8, 
  34 as c9, 
  case when (subq_0.c0 is not NULL) 
      or (24 is not NULL) then subq_0.c0 else subq_0.c0 end
     as c10, 
  cast(nullif(subq_0.c0,
    subq_0.c0) as VARCHAR(16)) as c11, 
  cast(coalesce(subq_0.c0,
    subq_0.c0) as VARCHAR(16)) as c12, 
  subq_0.c0 as c13, 
  cast(coalesce(subq_0.c0,
    cast(nullif(subq_0.c0,
      subq_0.c0) as VARCHAR(16))) as VARCHAR(16)) as c14, 
  subq_0.c0 as c15, 
  subq_0.c0 as c16, 
  subq_0.c0 as c17, 
  case when subq_0.c0 is NULL then subq_0.c0 else subq_0.c0 end
     as c18, 
  subq_0.c0 as c19
from 
  (select  
        ref_0.name as c0
      from 
        main.t0 as ref_0
      where 0) as subq_0
where subq_0.c0 is NULL
limit 85;
