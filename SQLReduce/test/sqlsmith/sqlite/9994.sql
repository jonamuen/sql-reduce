select  
  subq_0.c3 as c0, 
  subq_0.c8 as c1, 
  10 as c2
from 
  (select  
        ref_0.id as c0, 
        ref_0.name as c1, 
        ref_0.id as c2, 
        ref_0.name as c3, 
        ref_0.id as c4, 
        ref_0.name as c5, 
        case when ref_0.name is not NULL then ref_0.name else ref_0.name end
           as c6, 
        ref_0.id as c7, 
        ref_0.name as c8
      from 
        main.t0 as ref_0
      where ref_0.name is NULL
      limit 140) as subq_0
where case when (1) 
      or (1) then case when cast(nullif(subq_0.c5,
          subq_0.c6) as VARCHAR(16)) is NULL then subq_0.c8 else subq_0.c8 end
       else case when cast(nullif(subq_0.c5,
          subq_0.c6) as VARCHAR(16)) is NULL then subq_0.c8 else subq_0.c8 end
       end
     is not NULL;
