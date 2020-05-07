select  
  subq_1.c1 as c0, 
  84 as c1
from 
  (select  
        subq_0.c0 as c0, 
        subq_0.c0 as c1
      from 
        (select  
              ref_0.id as c0
            from 
              main.t0 as ref_0
            where (EXISTS (
                select  
                    ref_0.id as c0, 
                    ref_0.id as c1
                  from 
                    main.t0 as ref_1
                  where (0) 
                    or ((ref_1.name is not NULL) 
                      or ((ref_0.name is not NULL) 
                        and (0))))) 
              and (ref_0.id is NULL)) as subq_0
      where subq_0.c0 is NULL
      limit 127) as subq_1
where subq_1.c0 is NULL
limit 171;
