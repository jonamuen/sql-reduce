select  
  8 as c0, 
  53 as c1, 
  subq_0.c0 as c2, 
  cast(nullif(subq_0.c0,
    subq_0.c0) as VARCHAR(16)) as c3, 
  (select name from main.t0 limit 1 offset 4)
     as c4, 
  subq_0.c0 as c5, 
  subq_0.c0 as c6, 
  subq_0.c0 as c7
from 
  (select  
        ref_0.name as c0
      from 
        main.t0 as ref_0
      where ((1) 
          or ((ref_0.id is NULL) 
            or ((ref_0.id is not NULL) 
              and (((((1) 
                      and (55 is not NULL)) 
                    and ((0) 
                      and (ref_0.name is not NULL))) 
                  or ((1) 
                    or (ref_0.id is NULL))) 
                and (1))))) 
        or (((ref_0.id is not NULL) 
            and (0)) 
          and ((select name from main.t0 limit 1 offset 2)
               is NULL))
      limit 43) as subq_0
where (0) 
  or (subq_0.c0 is not NULL);
