select  
  subq_0.c0 as c0, 
  subq_0.c0 as c1, 
  subq_0.c0 as c2
from 
  (select  
        ref_0.id as c0
      from 
        main.t0 as ref_0
      where (0) 
        and (case when (ref_0.id is not NULL) 
              or (EXISTS (
                select  
                    ref_0.id as c0, 
                    38 as c1, 
                    52 as c2, 
                    ref_0.name as c3, 
                    ref_1.name as c4, 
                    ref_1.id as c5, 
                    (select id from main.t0 limit 1 offset 5)
                       as c6, 
                    ref_0.id as c7, 
                    ref_1.id as c8
                  from 
                    main.t0 as ref_1
                  where 0)) then ref_0.name else ref_0.name end
             is NULL)) as subq_0
where 1
limit 105;
