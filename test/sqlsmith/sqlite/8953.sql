select  
  subq_0.c0 as c0, 
  subq_0.c3 as c1
from 
  (select  
        ref_0.name as c0, 
        ref_0.id as c1, 
        case when ref_0.id is NULL then ref_0.name else ref_0.name end
           as c2, 
        ref_0.name as c3, 
        ref_0.name as c4, 
        ref_0.id as c5
      from 
        main.t0 as ref_0
      where (ref_0.name is NULL) 
        and ((((ref_0.id is not NULL) 
              and (((55 is NULL) 
                  and ((ref_0.name is not NULL) 
                    and (ref_0.id is NULL))) 
                or (ref_0.name is NULL))) 
            and (ref_0.id is NULL)) 
          or (ref_0.id is not NULL))
      limit 140) as subq_0
where (subq_0.c1 is not NULL) 
  or ((1) 
    and (subq_0.c1 is NULL));
