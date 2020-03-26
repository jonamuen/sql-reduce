select  
  subq_0.c1 as c0, 
  cast(nullif(subq_0.c2,
    subq_0.c4) as VARCHAR(16)) as c1, 
  subq_0.c1 as c2
from 
  (select  
        ref_0.name as c0, 
        ref_0.id as c1, 
        ref_0.name as c2, 
        (select name from main.t0 limit 1 offset 2)
           as c3, 
        (select name from main.t0 limit 1 offset 75)
           as c4
      from 
        main.t0 as ref_0
      where ((0) 
          or (((0) 
              and (ref_0.id is not NULL)) 
            or ((EXISTS (
                select  
                    ref_0.name as c0
                  from 
                    main.t0 as ref_1
                  where 1
                  limit 60)) 
              or (EXISTS (
                select  
                    ref_0.id as c0, 
                    ref_2.id as c1, 
                    ref_2.id as c2
                  from 
                    main.t0 as ref_2
                  where (12 is not NULL) 
                    and ((1) 
                      and (ref_0.id is NULL))
                  limit 137))))) 
        or (EXISTS (
          select  
              ref_0.name as c0, 
              ref_0.name as c1
            from 
              main.t0 as ref_3
            where ref_3.id is not NULL))
      limit 142) as subq_0
where subq_0.c2 is NULL
limit 37;
