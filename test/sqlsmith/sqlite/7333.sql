select  
  subq_0.c1 as c0, 
  subq_0.c0 as c1, 
  subq_0.c2 as c2, 
  subq_0.c1 as c3, 
  subq_0.c1 as c4, 
  subq_0.c0 as c5, 
  subq_0.c1 as c6
from 
  (select  
        ref_0.name as c0, 
        ref_0.id as c1, 
        case when EXISTS (
            select  
                ref_0.id as c0
              from 
                main.t0 as ref_1
              where (select name from main.t0 limit 1 offset 11)
                   is NULL
              limit 75) then ref_0.name else ref_0.name end
           as c2
      from 
        main.t0 as ref_0
      where (ref_0.id is not NULL) 
        and ((((ref_0.name is not NULL) 
              or (0)) 
            or ((select name from main.t0 limit 1 offset 3)
                 is not NULL)) 
          or (((0) 
              and (1)) 
            or (1)))) as subq_0
where 0
limit 58;
