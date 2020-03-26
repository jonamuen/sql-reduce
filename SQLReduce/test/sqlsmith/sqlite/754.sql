select  
  subq_1.c2 as c0, 
  subq_1.c7 as c1
from 
  (select  
        subq_0.c1 as c0, 
        subq_0.c2 as c1, 
        77 as c2, 
        cast(coalesce(subq_0.c1,
          subq_0.c0) as VARCHAR(16)) as c3, 
        subq_0.c1 as c4, 
        subq_0.c1 as c5, 
        subq_0.c1 as c6, 
        subq_0.c1 as c7
      from 
        (select  
              ref_0.name as c0, 
              ref_0.name as c1, 
              ref_0.id as c2
            from 
              main.t0 as ref_0
            where (((select id from main.t0 limit 1 offset 6)
                     is not NULL) 
                and (ref_0.name is NULL)) 
              and (((1) 
                  and (1)) 
                and (ref_0.name is not NULL))) as subq_0
      where (1) 
        and ((subq_0.c1 is NULL) 
          or (subq_0.c0 is NULL))
      limit 136) as subq_1
where (0) 
  and (EXISTS (
    select  
        subq_2.c1 as c0, 
        subq_1.c0 as c1, 
        case when (subq_2.c7 is NULL) 
            or ((58 is not NULL) 
              or (1)) then subq_1.c1 else subq_1.c1 end
           as c2, 
        subq_1.c0 as c3, 
        subq_2.c5 as c4, 
        subq_2.c7 as c5, 
        subq_2.c2 as c6, 
        subq_1.c3 as c7, 
        subq_2.c7 as c8
      from 
        (select  
              ref_1.name as c0, 
              subq_1.c7 as c1, 
              subq_1.c2 as c2, 
              subq_1.c4 as c3, 
              ref_1.name as c4, 
              subq_1.c4 as c5, 
              ref_1.id as c6, 
              ref_1.id as c7
            from 
              main.t0 as ref_1
            where ref_1.id is NULL
            limit 87) as subq_2
      where subq_2.c4 is NULL))
limit 164;
