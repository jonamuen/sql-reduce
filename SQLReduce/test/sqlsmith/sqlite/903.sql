select  
  subq_0.c2 as c0, 
  subq_0.c1 as c1, 
  subq_0.c1 as c2, 
  subq_0.c0 as c3, 
  subq_0.c0 as c4, 
  subq_0.c3 as c5, 
  case when (0) 
      and (0) then subq_0.c2 else subq_0.c2 end
     as c6, 
  subq_0.c1 as c7, 
  subq_0.c5 as c8, 
  case when 0 then subq_0.c2 else subq_0.c2 end
     as c9, 
  subq_0.c2 as c10, 
  subq_0.c3 as c11, 
  subq_0.c6 as c12, 
  92 as c13, 
  subq_0.c1 as c14
from 
  (select  
        (select id from main.t0 limit 1 offset 5)
           as c0, 
        ref_0.name as c1, 
        ref_0.name as c2, 
        ref_0.name as c3, 
        ref_0.name as c4, 
        ref_0.id as c5, 
        ref_0.name as c6
      from 
        main.t0 as ref_0
      where 0
      limit 152) as subq_0
where ((((subq_0.c0 is not NULL) 
        or (((1) 
            or (subq_0.c2 is NULL)) 
          and (subq_0.c6 is NULL))) 
      or (subq_0.c6 is not NULL)) 
    and (cast(coalesce(subq_0.c1,
        subq_0.c1) as VARCHAR(16)) is NULL)) 
  and (1)
limit 137;
