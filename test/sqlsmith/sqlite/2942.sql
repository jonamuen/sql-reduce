select  
  3 as c0, 
  subq_0.c0 as c1
from 
  (select  
        59 as c0, 
        ref_0.name as c1, 
        ref_0.name as c2, 
        ref_0.name as c3, 
        case when 1 then ref_0.name else ref_0.name end
           as c4
      from 
        main.t0 as ref_0
      where EXISTS (
        select  
            ref_1.name as c0, 
            ref_1.name as c1, 
            (select name from main.t0 limit 1 offset 1)
               as c2
          from 
            main.t0 as ref_1
          where (0) 
            or ((ref_1.id is not NULL) 
              and ((((0) 
                    and (ref_1.id is not NULL)) 
                  or (0)) 
                or ((ref_1.id is not NULL) 
                  or (((1) 
                      and (ref_1.id is not NULL)) 
                    or (1)))))
          limit 75)
      limit 166) as subq_0
where (subq_0.c0 is NULL) 
  or (subq_0.c3 is not NULL)
limit 50;
