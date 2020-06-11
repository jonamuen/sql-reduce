select  
  subq_1.c2 as c0, 
  subq_1.c7 as c1, 
  subq_1.c7 as c2, 
  subq_1.c0 as c3, 
  subq_1.c9 as c4, 
  case when 0 then subq_1.c1 else subq_1.c1 end
     as c5, 
  subq_1.c7 as c6, 
  subq_1.c6 as c7, 
  subq_1.c2 as c8, 
  subq_1.c6 as c9, 
  subq_1.c6 as c10, 
  subq_1.c7 as c11, 
  subq_1.c9 as c12, 
  subq_1.c10 as c13, 
  subq_1.c7 as c14, 
  subq_1.c9 as c15, 
  subq_1.c1 as c16, 
  subq_1.c8 as c17, 
  subq_1.c6 as c18, 
  subq_1.c10 as c19, 
  subq_1.c3 as c20, 
  subq_1.c4 as c21, 
  subq_1.c10 as c22, 
  cast(coalesce(cast(coalesce(subq_1.c0,
      case when (subq_1.c2 is NULL) 
          or (subq_1.c11 is NULL) then subq_1.c2 else subq_1.c2 end
        ) as VARCHAR(16)),
    subq_1.c2) as VARCHAR(16)) as c23, 
  subq_1.c5 as c24, 
  subq_1.c11 as c25, 
  subq_1.c5 as c26
from 
  (select  
        subq_0.c1 as c0, 
        subq_0.c0 as c1, 
        subq_0.c1 as c2, 
        subq_0.c5 as c3, 
        subq_0.c0 as c4, 
        subq_0.c4 as c5, 
        subq_0.c2 as c6, 
        subq_0.c5 as c7, 
        cast(coalesce(subq_0.c6,
          subq_0.c4) as INT) as c8, 
        subq_0.c5 as c9, 
        subq_0.c4 as c10, 
        (select id from main.t0 limit 1 offset 35)
           as c11
      from 
        (select  
              ref_0.id as c0, 
              ref_0.name as c1, 
              ref_0.name as c2, 
              ref_0.name as c3, 
              ref_0.id as c4, 
              ref_0.id as c5, 
              ref_0.id as c6
            from 
              main.t0 as ref_0
            where ref_0.name is not NULL
            limit 139) as subq_0
      where 0) as subq_1
where subq_1.c3 is NULL
limit 67;
